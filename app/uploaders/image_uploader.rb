# encoding: utf-8

class ImageUploader < ApplicationUploader
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  version :normal do
    process resize_to_fill: [250, 250]
  end

  version :small do
    process resize_to_fill: [100, 100]
  end
end
