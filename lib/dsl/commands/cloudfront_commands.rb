module CloudFrontCommands
  # Commands for CloudFront management
  # List CloudFront distribution points
  def cflist
    @commands[:cflist] = ''
    self
  end
  alias :cloudfront_list :cflist
  alias :cloudfront_ls :cflist
  alias :cfls :cflist

  # Display CloudFront distribution point parameters
  def cfinfo(dist_id) # [cf://DIST_ID]
    @commands[:cfinfo] = dist_id
    self
  end
  alias :cloudfront_info :cfinfo

  # Create CloudFront distribution point
  def cfcreate(bucket) # s3://BUCKET
    @commands[:cfcreate] = bucket
    self
  end
  alias :cloudfront_create :cfcreate
  alias :cloudfront_make :cfcreate
  alias :cfmake :cfcreate
  alias :cfmk :cfcreate

  # Delete CloudFront distribution point
  def cfdelete(dist_id) # cf://DIST_ID
    @commands[:cfdelete] = dist_id
    self
  end
  alias :cloudfront_delete :cfdelete

  # Change CloudFront distribution point parameters
  def cfmodify(dist_id) # cf://DIST_ID
    @commands[:cfmodify] = dist_id
    self
  end
  alias :cloudfront_modify :cfmodify
end
