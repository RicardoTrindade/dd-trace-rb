# frozen_string_literal: true

require_relative 'metrics_collection'

module Datadog
  module Core
    module Telemetry
      # MetricsManager aggregates and flushes metrics and distributions
      class MetricsManager
        def initialize(aggregation_interval:, enabled:)
          @interval = aggregation_interval
          @enabled = enabled
          @mutex = Mutex.new

          @collections = {}
        end

        def inc(namespace, metric_name, value, tags: {}, common: true)
          return unless @enabled

          collection = fetch_or_create_collection(namespace)
          collection.inc(metric_name, value, tags: tags, common: common)
        end

        def dec(namespace, metric_name, value, tags: {}, common: true)
          return unless @enabled

          collection = fetch_or_create_collection(namespace)
          collection.dec(metric_name, value, tags: tags, common: common)
        end

        def gauge(namespace, metric_name, value, tags: {}, common: true)
          return unless @enabled

          collection = fetch_or_create_collection(namespace)
          collection.gauge(metric_name, value, tags: tags, common: common)
        end

        def rate(namespace, metric_name, value, tags: {}, common: true)
          return unless @enabled

          collection = fetch_or_create_collection(namespace)
          collection.rate(metric_name, value, tags: tags, common: common)
        end

        def distribution(namespace, metric_name, value, tags: {}, common: true)
          return unless @enabled

          collection = fetch_or_create_collection(namespace)
          collection.distribution(metric_name, value, tags: tags, common: common)
        end

        def flush!(queue)
          return unless @enabled

          @mutex.synchronize do
            @collections.each_value { |col| col.flush!(queue) }
          end
          nil
        end

        private

        def fetch_or_create_collection(namespace)
          @mutex.synchronize do
            @collections[namespace] ||= MetricsCollection.new(namespace, aggregation_interval: @interval)
          end
        end
      end
    end
  end
end
