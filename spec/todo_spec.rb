# frozen_string_literal: true

require 'todo'

RSpec.describe Todo do
  describe Todo::TodoList, '#add!' do
    context 'when there are 2 items, no complete items' do
      todo = described_class.new(%w[foo bar])
      todo.add! 'baz'

      it 'adds an item' do
        expect(todo.items).to eq %w[foo bar baz]
      end

      it 'does not change completed items' do
        expect(todo.completed_items).to eq []
      end
    end
  end

  describe Todo::TodoList, '#complete' do
    context 'when the 2nd of the items is moved to a list of 3 completed items' do
      todo = described_class.new %w[a b c], %w[x y z]
      todo = todo.complete 1

      it 'removes the 2nd item from items' do
        expect(todo.items).to eq %w[a c]
      end

      it 'makes the 2nd item the 4th completed item' do
        expect(todo.completed_items).to eq %w[x y z b]
      end
    end
  end

  describe Todo::TodoList, '#complete!' do
    context 'when the 2nd of the items is moved to a list of 3 completed items' do
      todo = described_class.new %w[a b c], %w[x y z]
      todo.complete! 1

      it 'removes the 2nd item from items' do
        expect(todo.items).to eq %w[a c]
      end

      it 'makes the 2nd item the 4th completed item' do
        expect(todo.completed_items).to eq %w[x y z b]
      end
    end
  end

  describe '#find_lists' do
    context 'when "foo.yaml" and "bar.yaml" exist' do
      before do
        allow(Dir).to receive(:glob).and_return %w[foo.yaml bar.yaml]
      end

      it 'returns ["foo", "bar"]' do
        expect(described_class.find_lists).to eq %w[foo bar]
      end
    end
  end
end
