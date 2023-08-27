defmodule UndiOnlineWeb.ComponentLibrary do
  defmacro __using__(_) do
    quote do
      import UndiOnlineWeb.ComponentLibrary
      # Import additional component modules below
      import UndiOnlineWeb.Components.Dropdowns
      import UndiOnlineWeb.Components.Admin
      import UndiOnlineWeb.Components.Cards
      import UndiOnlineWeb.Components.Tables

    end
  end
  @moduledoc """
  This module is added and used in UndiOnlineWeb. The idea is
  different component modules can be added and imported in the macro section above.
  """
  use Phoenix.Component

end
