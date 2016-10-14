require "spec_helper"

describe Imagecache::Backend::Filesystem do

  before(:all) do
    @data = File.open("spec/public/images/sunset.jpg").read
    @key = "images/sunset.jpg"
  end

  it "can get file" do
    value = Imagecache::Backend::Filesystem.new("spec/public").get(@key)
    expect(value).to eq(@data)
  end

  it "can set file" do
    Imagecache::Backend::Filesystem.new("spec/public").set("imagecache/#{@key}", @data)
    value = File.open("spec/public/imagecache/#{@key}").read
    expect(value).to eq(@data)
    File.unlink("spec/public/imagecache/#{@key}")
  end

  it "can delete file" do
    File.open("spec/public/imagecache/images/sunset.jpg", "wb") { |file| file.write(@data) }
    Imagecache::Backend::Filesystem.new("spec/public").delete("imagecache/#{@key}")
    exists = File.exist?("spec/public/imagecache/#{@key}")
    expect(exists).to be false
  end

  it "can test for file existance" do
    exists = Imagecache::Backend::Filesystem.new("spec/public").exists?("imagecache/#{@key}")
    expect(exists).to be false
    File.open("spec/public/imagecache/#{@key}", "wb") { |file| file.write(@data) }
    exists = Imagecache::Backend::Filesystem.new("spec/public").exists?("imagecache/#{@key}")
    expect(exists).to be true
    File.unlink("spec/public/imagecache/#{@key}")
  end

end
