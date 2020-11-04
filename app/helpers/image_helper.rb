module ImageHelper

  def fetch_images(twit)
    if twit.original.images.attached?
      return render_images(twit.original.images)
    end
  end
  
  def render_images(images)
    render partial:"shared/image", collection: images
  end
end
