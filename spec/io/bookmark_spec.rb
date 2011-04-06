require 'spec_helper'

require 'io/bookmark'

text =<<TEXT
line 1
line 2
line 3
line 4
TEXT

shared 'an io object being bookmarked' do

  it 'returns to the original position after the bookmark block is over' do
    first_line = @io.gets
    start_pos = @io.pos
    start_pos.isnt 0
    inner_pos = nil
    @io.bookmark do |io|
      2.times { io.gets }
      inner_pos = io.pos
    end
    @io.pos.is start_pos
    @io.pos.isnt inner_pos
  end

end

describe 'bookmarking a file' do
  before do
    @tmpfile = TESTFILES + "/tmp.tmp"
    File.open(@tmpfile,'w') {|out| out.print text }
    @io = File.open(@tmpfile)
  end
  after do
    @io.close
    File.unlink(@tmpfile)
  end
  behaves_like 'an io object being bookmarked'
end

describe 'bookmarking a stringio' do
  before do
    @io = StringIO.new(text)
  end
  after do
    @io.close
  end
  behaves_like 'an io object being bookmarked'
end
