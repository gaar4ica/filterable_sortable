require "filterable_sortable/version"

module FilterableSortable

  extend ActiveSupport::Concern

  included do

    scope :filtered, lambda { |filter|
      if filter[:search]
        search(filter[:search])
      elsif filter[:custom] && filter[:custom] != 'all'
        self.send(filter[:custom].to_sym) if self.methods.include?(filter[:custom].to_sym)
      end
    }

    scope :search, lambda { |term|
      conditions = Array.new(self.attribute_names).delete_if{|i| i.in? ["created_at", "updated_at"] }.collect{|f| "#{self.table_name}.#{f} like '%#{term}%'"}.join(' OR ')
      where(conditions)
    }

    scope :ordered, lambda { |ordered|
      ordered[:field] = "#{self.table_name}.#{ordered[:field]}" unless ordered[:field].match(/\./)
      order("#{ordered[:field]} #{ordered[:direction]}") if ordered
    }

  end
end
