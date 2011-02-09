require "spec_helper.rb"
require 'ms/calc'

describe 'Ms::Calc - calculating ppm tolerances' do
  extend Ms::Calc
  
  it "returns the ppm tolerance at the specified mass, ppm" do
    ppm_tol_at(100, 100).is 0.01
    ppm_tol_at(1000, 100).is 0.1
    ppm_tol_at(1000, 10).is 0.01
  end
  
  it "works for any numeric inputs" do
    ppm_tol_at(100, 100).is 0.01
    ppm_tol_at(100.0, 100.0).is 0.01
    ppm_tol_at(1e2, 1e2).is 0.01
  end

  it "should return a span of ppm_tol_at centered on the specified mass" do
    ppm_span_at(100, 100).is [99.99, 100.01]
    ppm_span_at(1000, 100).is [999.9, 1000.1]
    ppm_span_at(1000, 10).is [999.99, 1000.01]
  end
  
  it "should work for any numeric inputs" do
    ppm_span_at(100, 100).is [99.99, 100.01]
    ppm_span_at(100.0, 100.0).is [99.99, 100.01]
    ppm_span_at(1e2, 1e2).is [99.99, 100.01]
  end
end
