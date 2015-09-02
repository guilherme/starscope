require File.expand_path('../../../test_helper', __FILE__)

describe Starscope::Lang::Javascript do
  before do
    @db = {}
    Starscope::Lang::Javascript.extract(JAVASCRIPT_SAMPLE, File.read(JAVASCRIPT_SAMPLE)) do |tbl, name, args|
      @db[tbl] ||= []
      @db[tbl] << Starscope::DB.normalize_record(JAVASCRIPT_SAMPLE, name, args)
    end
  end

  it 'must match javascript files' do
    Starscope::Lang::Javascript.match_file(JAVASCRIPT_SAMPLE).must_equal true
  end

  it 'must not match non-javascript files' do
    Starscope::Lang::Javascript.match_file(RUBY_SAMPLE).must_equal false
    Starscope::Lang::Javascript.match_file(EMPTY_FILE).must_equal false
  end

  it 'must identify function definitions' do
    @db.keys.must_include :defs
    defs = @db[:defs].map { |x| x[:name][-1] }

    defs.wont_include :a
    defs.wont_include :b
    defs.wont_include :c
    defs.must_include :d
    defs.must_include :e
    defs.must_include :f
    defs.must_include :g
    defs.wont_include :h
  end




end
