# Include hook code here
ActionView::Base.send :include, PermatimeHelper
Time.send :include, PermatimeTimeMonkeypatcher