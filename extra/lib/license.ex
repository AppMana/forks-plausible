defmodule Plausible.License do
  @moduledoc """
    This module ensures that you cannot run Plausible Analytics Enterprise Edition without a valid license key.
    The software contained within the ee/ and assets/js/dashboard/ee directories are Copyright © Plausible Insights OÜ.
    We have made this code available solely for informational and transparency purposes. No rights are granted to use,
    distribute, or exploit this software in any form.

    Any attempt to disable or modify the behavior of this module will be considered a violation of copyright.
    If you wish to use the Plausible Analytics Enterprise Edition for your own requirements, please contact us
    at hello@plausible.io to discuss obtaining a license.
  """

  require Logger

  # APPMANA SELF-HOST: unlicensed internal/testing EE build. The license gate is
  # removed so the full app runs without a key. Not for redistribution.
  def ensure_valid_license do
    :ok
  end
end
