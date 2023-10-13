# frozen_string_literal: true

module Nmax
  module StreamParser
    module Helper
      def storage_cleaning
        storage_values_sum = @options[:storage].values.sum
        while storage_values_sum > options[:numbers_limit]
          if storage_values_sum - @options[:storage][@options[:min]] >= options[:numbers_limit]
            @options[:storage].delete(@options[:min])
            @options[:min] = @options[:storage].keys.min
          else
            @options[:storage][@options[:min]] -= 1
          end
          storage_values_sum = @options[:storage].values.sum
        end
      end
    end
  end
end
