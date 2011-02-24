require 'spec_helper'

require 'ms/fasta'

describe 'basic fasta operations' do
  before do
    @headers = [">gi|5524211 [hello]", ">another B", ">again C"]
    @entries = ["LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV\nGLMPFLHTSKHRSMMLRPLSQALFWTLTMDLLTLTWIGSQPVEYPYTIIGQMASILYFSIILAFLPIAGX\nIENY", "ABCDEF\nGHIJK", "ABCD"]
    @sequences = @entries.map {|v| v.gsub("\n", '') }
    @data = {}
    @data['newlines'] = @headers.zip(@entries).map do |header, data|
      header + "\n" + data
    end.join("\n")
    @data['carriage_returns_and_newlines'] = @data['newlines'].gsub("\n", "\r\n")
    file_key_to_filename_pairs = @data.map do |k,v|
      file_key = k + '_file'
      filename = k + '.tmp'
      File.open(filename, 'w') {|out| out.print v }
      [file_key, filename]
    end
    file_key_to_filename_pairs.each {|k,v| @data[k] = v }
  end

  after do
    @data.select {|k,v| k =~ /_file$/ }.each do |k,filename|
      index = filename.sub('.tmp', '.index')
      [filename, index].each do |fn|
        File.unlink(fn) if File.exist? fn
      end
    end
  end

  def fasta_correct?(fasta)
    entries = fasta.map
    @headers.size.times.zip(entries) do |i,entry|
      header, sequence, entry = @headers[i], @sequences[i], entry
      entry.header.isnt nil
      entry.sequence.isnt nil
      entry.header.is header[1..-1]
      entry.sequence.is sequence
    end
  end

  it 'can read a file' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      Ms::Fasta.open(@data[file]) do |fasta|
        fasta_correct? fasta
      end
    end
  end

  it 'can read an IO object' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      File.open(@data[file]) do |io|
        fasta = Ms::Fasta.new(io)
        fasta_correct? fasta
      end
    end
  end

  it 'can read a string' do
    %w(newlines carriage_returns_and_newlines).each do |key|
      fasta = Ms::Fasta.new @data[key]
      fasta_correct? fasta
    end
  end

  it 'iterates entries with foreach' do
    %w(newlines_file carriage_returns_and_newlines_file).each do |file|
      Ms::Fasta.foreach(@data[file]) do |entry|
        entry.isa Bio::FastaFormat
      end
    end
  end

  it 'runs the documentation' do
    fasta_file = @data['newlines_file']
    ids = Ms::Fasta.open(fasta_file) do |fasta| 
      fasta.map(&:entry_id)
    end
    ids.is_a?(Array)
    ids.enums %w(gi|5524211 another again)
   
    # this code is already tested above
    # File.open(fasta_file) do |io| 
    #   fasta = Ms::Fasta.new(io)
    # end

    # taking a string
    string = ">id1 a simple header\nAAASDDEEEDDD\n>id2 header again\nPPPPPPWWWWWWTTTTYY\n"
    fasta = Ms::Fasta.new(string)
    (simple, not_simple) = fasta.partition {|entry| entry.header =~ /simple/ }
    simple.first.header.include?("simple").is true
    not_simple.first.header.include?("simple").is false
  end
end
