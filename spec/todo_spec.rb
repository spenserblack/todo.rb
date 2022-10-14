# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'
require 'yaml'
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

  describe Todo::TodoDir, '#list_path' do
    context 'when dir is /tmp/todo' do
      dir = described_class.new '/tmp/todo'

      it 'returns /tmp/todo/bar' do
        expect(dir.list_path('bar')).to eq '/tmp/todo/bar.yaml'
      end
    end
  end

  describe Todo::TodoDir, '#find_lists' do
    context 'when "foo.yaml" and "bar.yaml" exist' do
      dir = described_class.new '.'
      before do
        allow(Dir).to receive(:glob).and_return %w[foo.yaml bar.yaml]
      end

      it 'returns ["foo", "bar"]' do
        expect(dir.find_lists).to eq %w[foo bar]
      end
    end
  end

  describe Todo::TodoDir, '#load_list' do
    context 'when the desired file does not exist' do
      let!(:tmpdir) { Dir.mktmpdir }

      after do
        FileUtils.remove_entry tmpdir
      end

      it 'has empty pending todos' do
        dir = described_class.new tmpdir
        expect(dir.load_list('foo').items).to eq []
      end

      it 'has empty completed todos' do
        dir = described_class.new tmpdir
        expect(dir.load_list('foo').completed_items).to eq []
      end
    end

    context 'when "foo.yaml" does exist' do
      let!(:tmpdir) { Dir.mktmpdir }

      before do
        YAML.dump({ 'todo' => %w[a b c], 'done' => %w[x y z] }, File.open(File.join(tmpdir, 'foo.yaml'), 'w')).flush
      end

      after do
        FileUtils.remove_entry tmpdir
      end

      it 'has pending todos' do
        dir = described_class.new tmpdir
        expect(dir.load_list('foo').items).to eq %w[a b c]
      end

      it 'has completed todos' do
        dir = described_class.new tmpdir
        expect(dir.load_list('foo').completed_items).to eq %w[x y z]
      end
    end
  end

  describe Todo::TodoDir, '#save_list' do
    let!(:tmpdir) { Dir.mktmpdir }

    after do
      FileUtils.remove_entry tmpdir
    end

    it 'saves the list' do
      dir = described_class.new tmpdir
      f = dir.save_list 'foo', Todo::TodoList.new(%w[a b c], %w[x y z])
      expected = { 'todo' => %w[a b c], 'done' => %w[x y z] }
      f.seek 0
      expect(YAML.load_file(f)).to eq expected
    end
  end
end
