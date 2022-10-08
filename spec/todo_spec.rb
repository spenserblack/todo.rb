require 'todo'

RSpec.describe Todo::TodoList, '#complete' do
  context 'when there are 3 items and 3 completed items' do
    it 'should return a new Todo with the middle item moved to the last completed item' do
      todo = Todo::TodoList.new %w[a b c], %w[x y z]
      todo = todo.complete 1
      expect(todo.items).to eq %w[a c]
      expect(todo.completed_items).to eq %w[x y z b]
    end
  end
end

RSpec.describe Todo::TodoList, '#complete!' do
  context 'when there are 3 items and 3 completed items' do
    it 'should return a new Todo with the middle item moved to the last completed item' do
      todo = Todo::TodoList.new %w[a b c], %w[x y z]
      todo.complete! 1
      expect(todo.items).to eq %w[a c]
      expect(todo.completed_items).to eq %w[x y z b]
    end
  end
end
