# encoding: utf-8

module Imagecache

  class Identify

    def identify(file)
      output = `identify -verbose #{file.path}`
      geometry = output.match(/Geometry: (\d*)x(\d*)\+(\d*)\+(\d*)$/)
      created = output.match(/date:create: (.*)$/)
      content_type = output.match(/Mime type: (.*)$/)
      OpenStruct.new(width: geometry[1].to_i, height: geometry[2].to_i, created: created[1], content_type: content_type[1])
    end

  end
  
end
