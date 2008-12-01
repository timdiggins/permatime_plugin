module PermatimeTimeMonkeypatcher
  def permatime(options={})
    PermatimeHelper.permatime_url(self, options)
  end
end