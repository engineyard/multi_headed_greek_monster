require 'multi_headed_greek_monster'
require 'test/unit'
require 'forwardable'
require 'cubbyhole/base'

class Face < Cubbyhole::Base
  def self.find_in_batches
    batch = []
    self.all.each_with_index do |item, index|
      batch << item
      if index % 10 == 9
        yield batch
        batch = []
      end
    end
  end
end

class MultiHeadedGreekMonsterTest < Test::Unit::TestCase
  
  def test_should_work
    100.times{|x| Face.create(:name => "#{x}-#{rand}") }
    monster = MultiHeadedGreekMonster.new(nil, 3, 28371) do |face, work|
      puts "working on #{face.id} from #{Process.pid}"
      face.name = face.name + " improved"
      face.save!
      work.result(face.name)
      puts "face renamed to " + face.name.inspect
    end
    total = Face.all.size
    Face.find_in_batches do |batch_of_things|
      batch_of_things.each do |thing|
        puts "feed #{thing.id}"
        monster.feed(thing)   
      end
      puts "waiting..."
      monster.wait
    end
    puts "finishing..."
    results = monster.finish
    assert_equal(results.size, total)
  end
  
end
