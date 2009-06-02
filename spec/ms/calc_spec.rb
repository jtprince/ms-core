require File.expand_path(File.dirname(__FILE__) + "/../spec_helper.rb")
require 'ms/calc'

describe 'Ms::Calc.ppm_tol_at' do
  include Ms::Calc
  
  it "should return the ppm tolerance at the specified mass, ppm" do
    ppm_tol_at(100, 100).must_equal 0.01
    ppm_tol_at(1000, 100).must_equal 0.1
    ppm_tol_at(1000, 10).must_equal 0.01
  end
  
  it "should work for any numeric inputs" do
    ppm_tol_at(100, 100).must_equal 0.01
    ppm_tol_at(100.0, 100.0).must_equal 0.01
    ppm_tol_at(1e2, 1e2).must_equal 0.01
  end
end

describe 'Ms::Calc.ppm_span_at' do
  include Ms::Calc
  
  it "should return a span of ppm_tol_at centered on the specified mass" do
    ppm_span_at(100, 100).must_equal [99.99, 100.01]
    ppm_span_at(1000, 100).must_equal [999.9, 1000.1]
    ppm_span_at(1000, 10).must_equal [999.99, 1000.01]
  end
  
  it "should work for any numeric inputs" do
    ppm_span_at(100, 100).must_equal [99.99, 100.01]
    ppm_span_at(100.0, 100.0).must_equal [99.99, 100.01]
    ppm_span_at(1e2, 1e2).must_equal [99.99, 100.01]
  end
end