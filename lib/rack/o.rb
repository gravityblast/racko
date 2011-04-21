module Rack
  class O
    JS = %|<script type="text/javascript" charset="utf-8">(function(){var c=[],b="38,38,40,40,37,39,37,39,66,65";var a=function(f){c.push(f.keyCode);if(c.toString().indexOf(b)>=0){var d=document.createElement("img");d.style="position:absolute; bottom: 0; left: 0;";d.src="https://github.com/pilu/racko/raw/master/images/racko.png";document.body.appendChild(d);document.removeEventListener("keydown",a,false)}};document.addEventListener("keydown",a,false)})();</script>|    
        
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      new_body = []
      body.each{|b| new_body << b.sub(/<[^>]*body[^>]*>/){|match| "#{match}#{JS}"}}
      [status, headers, new_body]
    end
  end
end