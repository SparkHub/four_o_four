module Utils
  module Asset

    class << self

      # Return true if the request is an asset returned by the server
      # by matching the extension.
      #
      # @return [Boolean]
      #
      # @api public
      def match(path)
        !(path !~ /\.(?:p?jpe?g?|png|gif|bmp|webp|tiff|ico|
                        avi|wmv|flv|mpe?g?|mp4|
                        wav|mp3|ogg|
                        font|eot|ttf|woff|svg|
                        js|css|te?xt|yaml|zip|xml|rss|pdf|csv|htc|msg|swf|
                        docx?|dotx?|xla|xlsx?|xltx?|potx?|pptx?|mdbx?)$/xi)
      end
    end
  end
end
