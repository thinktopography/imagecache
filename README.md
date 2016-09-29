# Imagecache
An image cropping and caching library written in Ruby

## Installation

```sh
gem install imagecache
```

## Usage

In your routes file:
```Ruby
get 'imagecache/*permalink' => 'imagecache#show', :permalink => /imagecache\/.*/
```

In your controller:
```Ruby
class ImagecacheController < ApplicationController

  def show
    imagecache = Imagecache::Base.new
    if image = imagecache.process(params[:permalink])
      redirect_to params[:permalink], status: 301
    else
      render text: '', status: 404
    end
  end

end
```

If you have the file `image.jpg` in your `public/assets` folder, then point
your browser to `http://example.com/imagecache/assets/ft250x250/image.jpg` to
get a cropped version of `image.jpg` that fits within a 250x250 pixel cropping.
