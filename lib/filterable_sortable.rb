require "filterable_sortable/version"

module FilterableSortable

  extend ActiveSupport::Concern

  included do

    scope :filtered, lambda { |filter|
      if filter[:search]
        search(filter[:search])
      elsif filter[:custom] && filter[:custom] != 'all'
        if methods.include?(filter[:custom].to_sym) &&
          !(filter[:custom] =~ /delete_|update_|create|drop_|destroy_|\!/)
          readonly.send(filter[:custom].to_sym)
        end
      end
    }

    scope :search, lambda { |term|
      conditions =
        columns_hash.
        map { |k, v| k unless v.type.in?([:datetime, :time, :date]) }.
        compact.
        map do |f|
          "#{table_name}.#{f} like " \
          "#{ActiveRecord::Base.sanitize('%#{term}%')}"
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
        case ordered[:direction].to_s.capitalize
        when "ASC"
          order(ordered[:field] => :ASC)
        when "DESC"
          order(ordered[:field] => :DESC)
        else
          order(ordered[:field])
        end
      end
    }

  end
end
