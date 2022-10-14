# frozen_string_literal: true

require 'fileutils'
require 'yaml'

# Writes and reads TODOs to and from YAML files
class Todo
  # TodoList represents a list of items to do, and those that are done.
  class TodoList
    attr_reader :items, :completed_items

    def initialize(items, completed_items = [])
      @items = items
      @completed_items = completed_items
    end

    # Adds a new item to do.
    def add!(item)
      @items << item
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

      TodoList.new(new_items, new_completed_items)
    end

    # Completes one or more items.
    def complete!(item_index, *other_item_indices)
      [item_index, *other_item_indices].sort.reverse_each { |index| @completed_items << @items.delete_at(index) }
    end

    def to_h
      { 'todo' => items, 'done' => completed_items }
    end

    def to_yaml
      YAML.dump(to_h)
    end

    def to_s
      to_yaml
    end
  end

  def self.todo_dir
    File.join Dir.home, '.todo'
  end

  def self.filename(name)
    File.join todo_dir, "#{name}.yaml"
  end

  def self.find_lists
    Dir.glob("#{todo_dir}/*.yaml").map { |file| File.basename(file, '.yaml') }
  end

  def self.load_list(name)
    FileUtils.mkdir_p todo_dir
    File.write filename(name), YAML.dump(TodoList.new([]).to_h) unless File.exist? filename(name)
    list = YAML.load_file(filename(name))
    TodoList.new(list.fetch('todo', []), list.fetch('done', []))
  end

  def self.save_list(name, list)
    YAML.dump(list.to_h, File.open(filename(name), 'w'))
  end
end
