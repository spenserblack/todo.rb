# frozen_string_literal: true

class Todo
  # TodoList represents a list of items to do, and those that are done.
  class TodoList
    attr_reader :items, :completed_items

    def initialize(items, completed_items = [])
      @items = items
      @completed_items = completed_items
    end

    # Completes one or more items, returning a new TodoList.
    def complete(item_index, *other_item_indexes)
      indices = Set.new([item_index, *other_item_indexes])
      new_completed_items = @completed_items.dup
      new_items = items.filter.with_index do |item, i|
        includes = indices.include?(i)
        new_completed_items << item if includes
        !includes
      end

      new(new_items, new_completed_items)
    end

    # Completes one or more items.
    def complete!(item_index, *other_item_indices)
      [item_index, *other_item_indices].sort.reverse_each { |index| @completed_items << @items.delete_at(index) }
    end
  end
end
