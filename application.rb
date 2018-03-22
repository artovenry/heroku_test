include Recaptcha::Verify

class Application < ApplicationBase
  set :show_exceptions, :after_handler
  before do
    if request.content_length.to_i > 0
      request.body.rewind
      @body= JSON.parse request.body.read, symbolize_names: true
    end
  end

  get "/" do
    json response: {
      status: :success,
      data: {
        items: Item.all
      }
    }
  end

  post "/" do
    json response: {
      status: verify_recaptcha ?  :success : :fail,
      data: {hoge: "boo"}
      token: params['g-recaptcha-response']
    }
  end


end
