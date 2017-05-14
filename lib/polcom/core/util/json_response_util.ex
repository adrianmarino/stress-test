defmodule Core.Phoenix.JSONResponseUtil do
  import Core.JSON

  defmacro send_body_resp(conn, status, body) do
    quote bind_quoted: [conn: conn, status: status, body: body] do
      send_resp(conn, status, to_json(body))
    end
  end

  defmacro send_message_resp(conn, status, message) do
    quote bind_quoted: [conn: conn, status: status, message: message] do
      send_resp(conn, status, to_json(%{message: message}))
    end
  end

  defmacro send_error_resp(conn, status, message) do
    quote bind_quoted: [conn: conn, status: status, message: message] do
      send_resp(conn, status, to_json(%{error: message}))
    end
  end
end
