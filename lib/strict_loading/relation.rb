module StrictLoading
  module Relation
    private

    def exec_queries
      super.tap do |records|
        unless strict_loading_value.nil?
          records.each do |record|
            record.strict_loading!
          end
        end
      end
    end
  end
end
