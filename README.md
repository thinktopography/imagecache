# Imagecache
An image cropping and caching library written in Ruby

<table>
  <tr>
    <td>Build Status</td>
    <td>
      <a href="https://circleci.com/gh/thinktopography/imageache">
        <img src="https://img.shields.io/circleci/project/thinktopography/imagecache.svg?maxAge=600" alt="Build Status" >
      </a>
    </td>
  </tr>
  <tr>
    <td>Code Quality</td>
    <td>
      <a href="https://codeclimate.com/github/thinktopography/imagecache">
        <img src="https://img.shields.io/codeclimate/github/thinktopography/imagecache.svg?maxAge=600" alt="Code Climate" />
      </a>
      <a href="https://codeclimate.com/github/thinktopography/imagecache/coverage">
        <img src="https://img.shields.io/codeclimate/coverage/github/thinktopography/imagecache.svg?maxAge=600" alt="Code Coverage" />
      </a>
    </td>
  </tr>
</table>
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
