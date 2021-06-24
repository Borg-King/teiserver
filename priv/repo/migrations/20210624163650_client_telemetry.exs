defmodule Central.Repo.Migrations.ClientTelemetry do
  use Ecto.Migration

  def change do
    create table(:teiserver_telemetry_events) do
      add :name, :string
    end

    create table(:teiserver_telemetry_client_events) do
      add :user_id, references(:account_users, on_delete: :nothing)
      add :timestamp, :utc_datetime

      add :event_id, references(:teiserver_telemetry_events, on_delete: :nothing)
      add :value, :string
    end

    create table(:teiserver_telemetry_client_properties, primary_key: false) do
      add :user_id, references(:account_users, on_delete: :nothing), primary_key: true
      add :last_updated, :utc_datetime

      add :event_id, references(:teiserver_telemetry_events, on_delete: :nothing), primary_key: true
      add :value, :string
    end

    create table(:teiserver_telemetry_battle_events) do
      add :user_id, references(:account_users, on_delete: :nothing)
      add :battle_id, :integer
      add :timestamp, :utc_datetime

      add :event_id, references(:teiserver_telemetry_events, on_delete: :nothing)
      add :value, :string
    end
  end
end
