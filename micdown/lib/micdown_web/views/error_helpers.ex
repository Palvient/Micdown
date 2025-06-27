defmodule MicdownWeb.ErrorHelpers do
  import Phoenix.HTML
  import Phoenix.HTML.Form
  use PhoenixHTMLHelpers  # <- this restores content_tag/3 and others

  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error),
        class: "text-red-600 text-sm",
        phx_feedback_for: input_id(form, field)
      )
    end)
  end

  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(MicdownWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(MicdownWeb.Gettext, "errors", msg, opts)
    end
  end
end
