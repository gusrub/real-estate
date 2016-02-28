module ApplicationHelper

  def unsupported_format_response(format)
    case format
    when :xml
      return { "error": "Unsupported request format" }
    when :json
      return { "error": "Unsupported request format" }
    end
  end

end