# frozen_string_literal: true

module Wilhelm::SDK
  class ApplicationContext
    # Comment
    module Nodes
      include Constants
      include Logging

      def announcement(node)
        logger.unknown('TEMP') { "#announcement(#{node})" }
        logger.unknown('TEMP') { "node klass: #{node.class}" }
        node = node.to_sym unless node.is_a?(Symbol)
        return false if nodes.include?(node)
        new_node = Node.new(node)
        new_node.connect
        nodes[node] = new_node
      end

      def nodes
        @nodes ||= {}
      end
    end
  end
end
