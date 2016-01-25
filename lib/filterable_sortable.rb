require "filterable_sortable/version"

module FilterableSortable

  extend ActiveSupport::Concern

  included do

    scope :filtered, lambda { |filter|
      if filter[:search]
        search(filter[:search])
      elsif filter[:custom] && filter[:custom] != 'all'
        if methods.include?(filter[:custom].to_sym) &&
          !dangerous_filtered_method?(filter[:custom])
          readonly.send(filter[:custom].to_sym)
        end
      end
    }

    scope :search, lambda { |term|
      conditions =
        columns_hash.
        select { |_, v| !v.type.in?(excluded_search_types) }.
        keys.
        map do |f|
          "#{table_name}.#{f} like " \
          "#{ActiveRecord::Base.sanitize("%#{term}%")}"
        end.
        join(' OR ')
      where(conditions)
    }

    scope :ordered, lambda { |ordered|
      ordered[:field] =
        if ordered[:field] =~ /\./
          ActiveRecord::Base.sanitize "#{table_name}.#{ordered[:field]}"
        else
          ActiveRecord::Base.sanitize ordered[:field]
        end
      if ordered
        if ordered[:direction].to_s.capitalize == "DESC"
          order(ordered[:field] => :DESC)
        else
          order(ordered[:field])
        end
      end
    }

    private

    def self.dangerous_filtered_method?(method)
      method =~ /delete_|update_|create|drop_|destroy_|\!/
    end

    def self.excluded_search_types
      [:datetime, :time, :date].freeze
    end

  end
end
