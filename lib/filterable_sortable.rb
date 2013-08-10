require "filterable_sortable/version"

module FilterableSortable

  extend ActiveSupport::Concern

  included do
    scope :filtered, lambda { |filtered| }
    scope :ordered, lambda { |ordered| order("#{ordered[:field]} #{ordered[:direction]}") if ordered }
  end

end
