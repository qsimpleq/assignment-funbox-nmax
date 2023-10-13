# frozen_string_literal: true

module Nmax
  module StreamParser
    module Helper
      def storage_cleaning
        storage_values_sum = @options[:storage].values.sum
        while storage_values_sum > options[:numbers_limit]
          storage_cleaning_reducer(storage_values_sum)
          storage_values_sum = @options[:storage].values.sum
        end
      end

      def storage_delete_min
        @options[:storage].delete(@options[:min])
        @options[:min] = @options[:storage].keys.min
      end

      def storage_delete_or_decrement_min
        if @options[:storage][@options[:min]] > 1
          @options[:storage][@options[:min]] -= 1
        else
          storage_delete_min
        end
      end

      def storage_add(current_number)
        @options[:storage][current_number] = 0 unless @options[:storage].key?(current_number)
        @options[:storage][current_number] += 1
      end

      def recalc_storage_if_new_max_find(current_number)
        return if @options[:storage].keys.size < options[:numbers_limit]
        return if current_number <= @options[:max]

        storage_delete_or_decrement_min
      end

      def recalc_min_max(current_number)
        @options[:min] = current_number if @options[:min].nil? || @options[:min] > current_number
        @options[:max] = current_number if @options[:max].nil? || @options[:max] < current_number
      end

      private

      def storage_cleaning_reducer(storage_values_sum)
        if storage_values_sum - @options[:storage][@options[:min]] >= options[:numbers_limit]
          storage_delete_min
        else
          @options[:storage][@options[:min]] -= 1
        end
      end
    end
  end
end
