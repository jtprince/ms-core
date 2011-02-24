require 'spec_helper'

require 'ms/mass/aa'

describe 'using a mass table' do
  it 'has monoisotopic masses by string or symbol' do
    Ms::Mass::AA::MONO['A'].is 71.0371137878
    Ms::Mass::AA::MONO[:A].is 71.0371137878
  end
  it 'has average masses by string or symbol' do
    Ms::Mass::AA::AVG['A'].is 71.0779
    Ms::Mass::AA::AVG[:A].is 71.0779
  end
end
