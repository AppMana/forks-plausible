defmodule Plausible.IngestRepo do
  @moduledoc """
  Write-centric Clickhouse access interface
  """

  use Ecto.Repo,
    otp_app: :plausible,
    adapter: Ecto.Adapters.ClickHouse

  defmacro __using__(_) do
    quote do
      alias Plausible.IngestRepo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  # APPMANA: we run on a ClickHouse `Replicated` database engine (the plausible
  # DB is created with ENGINE = Replicated, see the deployment manifest). That
  # engine replicates every DDL statement to all replicas by itself, and our
  # data tables (events_v2/sessions_v2) use ReplicatedMergeTree for data
  # replication. ON CLUSTER queries are FORBIDDEN inside a Replicated database,
  # so we must always report "not clustered" — upstream's system.replicas
  # auto-detection would return true once the tables exist and inject ON CLUSTER
  # into later ALTER migrations, which then fail.
  def clustered_table?(_table), do: false

  def replica_count(table) do
    {:ok, %{rows: [[count]]}} =
      query("SELECT sum(active_replicas) FROM system.replicas WHERE table = '#{table}'")

    count
  end
end
