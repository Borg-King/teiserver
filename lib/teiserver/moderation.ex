defmodule Teiserver.Moderation do
  import Ecto.Query, warn: false
  alias Central.Repo
  # require Logger
  # alias Teiserver.Data.Types, as: T
  alias Central.Helpers.QueryHelpers

  alias Teiserver.Moderation.{Report, ReportLib}


  @spec icon :: String.t()
  defdelegate icon(), to: ReportLib

  @spec colour :: atom
  defdelegate colour(), to: ReportLib

  @spec report_query(List.t()) :: Ecto.Query.t()
  def report_query(args) do
    report_query(nil, args)
  end

  @spec report_query(Integer.t(), List.t()) :: Ecto.Query.t()
  def report_query(id, args) do
    ReportLib.query_reports
      |> ReportLib.search(%{id: id})
      |> ReportLib.search(args[:search])
      |> ReportLib.preload(args[:preload])
      |> ReportLib.order_by(args[:order_by])
      |> QueryHelpers.select(args[:select])
  end

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  @spec list_reports(List.t()) :: List.t()
  def list_reports(args \\ []) do
    report_query(args)
      |> QueryHelpers.limit_query(args[:limit] || 50)
      |> Repo.all
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_report!(Integer.t() | List.t()) :: Report.t()
  @spec get_report!(Integer.t(), List.t()) :: Report.t()
  def get_report!(id) when not is_list(id) do
    report_query(id, [])
      |> Repo.one!
  end
  def get_report!(args) do
    report_query(nil, args)
      |> Repo.one!
  end
  def get_report!(id, args) do
    report_query(id, args)
      |> Repo.one!
  end

  # Uncomment this if needed, default files do not need this function
  # @doc """
  # Gets a single report.

  # Returns `nil` if the Report does not exist.

  # ## Examples

  #     iex> get_report(123)
  #     %Report{}

  #     iex> get_report(456)
  #     nil

  # """
  # def get_report(id, args \\ []) when not is_list(id) do
  #   report_query(id, args)
  #   |> Repo.one
  # end

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_report(Map.t()) :: {:ok, Report.t()} | {:error, Ecto.Changeset.t()}
  def create_report(attrs \\ %{}) do
    %Report{}
      |> Report.changeset(attrs)
      |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_report(Report.t(), Map.t()) :: {:ok, Report.t()} | {:error, Ecto.Changeset.t()}
  def update_report(%Report{} = report, attrs) do
    report
      |> Report.changeset(attrs)
      |> Repo.update()
  end

  @doc """
  Deletes a Report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_report(Report.t()) :: {:ok, Report.t()} | {:error, Ecto.Changeset.t()}
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  @spec change_report(Report.t()) :: Ecto.Changeset.t()
  def change_report(%Report{} = report) do
    Report.changeset(report, %{})
  end

  alias Teiserver.Moderation.{Action, ActionLib}

  @spec action_query(List.t()) :: Ecto.Query.t()
  def action_query(args) do
    action_query(nil, args)
  end

  @spec action_query(Integer.t(), List.t()) :: Ecto.Query.t()
  def action_query(id, args) do
    ActionLib.query_actions
    |> ActionLib.search(%{id: id})
    |> ActionLib.search(args[:search])
    |> ActionLib.preload(args[:preload])
    |> ActionLib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
  end

  @doc """
  Returns the list of actions.

  ## Examples

      iex> list_actions()
      [%Action{}, ...]

  """
  @spec list_actions(List.t()) :: List.t()
  def list_actions(args \\ []) do
    action_query(args)
    |> QueryHelpers.limit_query(args[:limit] || 50)
    |> Repo.all
  end

  @doc """
  Gets a single action.

  Raises `Ecto.NoResultsError` if the Action does not exist.

  ## Examples

      iex> get_action!(123)
      %Action{}

      iex> get_action!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_action!(Integer.t() | List.t()) :: Action.t()
  @spec get_action!(Integer.t(), List.t()) :: Action.t()
  def get_action!(id) when not is_list(id) do
    action_query(id, [])
    |> Repo.one!
  end
  def get_action!(args) do
    action_query(nil, args)
    |> Repo.one!
  end
  def get_action!(id, args) do
    action_query(id, args)
    |> Repo.one!
  end

  # Uncomment this if needed, default files do not need this function
  # @doc """
  # Gets a single action.

  # Returns `nil` if the Action does not exist.

  # ## Examples

  #     iex> get_action(123)
  #     %Action{}

  #     iex> get_action(456)
  #     nil

  # """
  # def get_action(id, args \\ []) when not is_list(id) do
  #   action_query(id, args)
  #   |> Repo.one
  # end

  @doc """
  Creates a action.

  ## Examples

      iex> create_action(%{field: value})
      {:ok, %Action{}}

      iex> create_action(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_action(Map.t()) :: {:ok, Action.t()} | {:error, Ecto.Changeset.t()}
  def create_action(attrs \\ %{}) do
    %Action{}
    |> Action.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action.

  ## Examples

      iex> update_action(action, %{field: new_value})
      {:ok, %Action{}}

      iex> update_action(action, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_action(Action.t(), Map.t()) :: {:ok, Action.t()} | {:error, Ecto.Changeset.t()}
  def update_action(%Action{} = action, attrs) do
    action
    |> Action.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Action.

  ## Examples

      iex> delete_action(action)
      {:ok, %Action{}}

      iex> delete_action(action)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_action(Action.t()) :: {:ok, Action.t()} | {:error, Ecto.Changeset.t()}
  def delete_action(%Action{} = action) do
    Repo.delete(action)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action changes.

  ## Examples

      iex> change_action(action)
      %Ecto.Changeset{source: %Action{}}

  """
  @spec change_action(Action.t()) :: Ecto.Changeset.t()
  def change_action(%Action{} = action) do
    Action.changeset(action, %{})
  end



  alias Teiserver.Moderation.{Proposal, ProposalLib}

  @spec proposal_query(List.t()) :: Ecto.Query.t()
  def proposal_query(args) do
    proposal_query(nil, args)
  end

  @spec proposal_query(Integer.t(), List.t()) :: Ecto.Query.t()
  def proposal_query(id, args) do
    ProposalLib.query_proposals
    |> ProposalLib.search(%{id: id})
    |> ProposalLib.search(args[:search])
    |> ProposalLib.preload(args[:preload])
    |> ProposalLib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
  end

  @doc """
  Returns the list of proposals.

  ## Examples

      iex> list_proposals()
      [%Proposal{}, ...]

  """
  @spec list_proposals(List.t()) :: List.t()
  def list_proposals(args \\ []) do
    proposal_query(args)
    |> QueryHelpers.limit_query(args[:limit] || 50)
    |> Repo.all
  end

  @doc """
  Gets a single proposal.

  Raises `Ecto.NoResultsError` if the Proposal does not exist.

  ## Examples

      iex> get_proposal!(123)
      %Proposal{}

      iex> get_proposal!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_proposal!(Integer.t() | List.t()) :: Proposal.t()
  @spec get_proposal!(Integer.t(), List.t()) :: Proposal.t()
  def get_proposal!(id) when not is_list(id) do
    proposal_query(id, [])
    |> Repo.one!
  end
  def get_proposal!(args) do
    proposal_query(nil, args)
    |> Repo.one!
  end
  def get_proposal!(id, args) do
    proposal_query(id, args)
    |> Repo.one!
  end

  # Uncomment this if needed, default files do not need this function
  # @doc """
  # Gets a single proposal.

  # Returns `nil` if the Proposal does not exist.

  # ## Examples

  #     iex> get_proposal(123)
  #     %Proposal{}

  #     iex> get_proposal(456)
  #     nil

  # """
  # def get_proposal(id, args \\ []) when not is_list(id) do
  #   proposal_query(id, args)
  #   |> Repo.one
  # end

  @doc """
  Creates a proposal.

  ## Examples

      iex> create_proposal(%{field: value})
      {:ok, %Proposal{}}

      iex> create_proposal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_proposal(Map.t()) :: {:ok, Proposal.t()} | {:error, Ecto.Changeset.t()}
  def create_proposal(attrs \\ %{}) do
    %Proposal{}
    |> Proposal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a proposal.

  ## Examples

      iex> update_proposal(proposal, %{field: new_value})
      {:ok, %Proposal{}}

      iex> update_proposal(proposal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_proposal(Proposal.t(), Map.t()) :: {:ok, Proposal.t()} | {:error, Ecto.Changeset.t()}
  def update_proposal(%Proposal{} = proposal, attrs) do
    proposal
    |> Proposal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Proposal.

  ## Examples

      iex> delete_proposal(proposal)
      {:ok, %Proposal{}}

      iex> delete_proposal(proposal)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_proposal(Proposal.t()) :: {:ok, Proposal.t()} | {:error, Ecto.Changeset.t()}
  def delete_proposal(%Proposal{} = proposal) do
    Repo.delete(proposal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking proposal changes.

  ## Examples

      iex> change_proposal(proposal)
      %Ecto.Changeset{source: %Proposal{}}

  """
  @spec change_proposal(Proposal.t()) :: Ecto.Changeset.t()
  def change_proposal(%Proposal{} = proposal) do
    Proposal.changeset(proposal, %{})
  end

    alias Teiserver.Moderation.{Ban, BanLib}

  @spec ban_query(List.t()) :: Ecto.Query.t()
  def ban_query(args) do
    ban_query(nil, args)
  end

  @spec ban_query(Integer.t(), List.t()) :: Ecto.Query.t()
  def ban_query(id, args) do
    BanLib.query_bans
    |> BanLib.search(%{id: id})
    |> BanLib.search(args[:search])
    |> BanLib.preload(args[:preload])
    |> BanLib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
  end

  @doc """
  Returns the list of bans.

  ## Examples

      iex> list_bans()
      [%Ban{}, ...]

  """
  @spec list_bans(List.t()) :: List.t()
  def list_bans(args \\ []) do
    ban_query(args)
    |> QueryHelpers.limit_query(args[:limit] || 50)
    |> Repo.all
  end

  @doc """
  Gets a single ban.

  Raises `Ecto.NoResultsError` if the Ban does not exist.

  ## Examples

      iex> get_ban!(123)
      %Ban{}

      iex> get_ban!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_ban!(Integer.t() | List.t()) :: Ban.t()
  @spec get_ban!(Integer.t(), List.t()) :: Ban.t()
  def get_ban!(id) when not is_list(id) do
    ban_query(id, [])
    |> Repo.one!
  end
  def get_ban!(args) do
    ban_query(nil, args)
    |> Repo.one!
  end
  def get_ban!(id, args) do
    ban_query(id, args)
    |> Repo.one!
  end

  # Uncomment this if needed, default files do not need this function
  # @doc """
  # Gets a single ban.

  # Returns `nil` if the Ban does not exist.

  # ## Examples

  #     iex> get_ban(123)
  #     %Ban{}

  #     iex> get_ban(456)
  #     nil

  # """
  # def get_ban(id, args \\ []) when not is_list(id) do
  #   ban_query(id, args)
  #   |> Repo.one
  # end

  @doc """
  Creates a ban.

  ## Examples

      iex> create_ban(%{field: value})
      {:ok, %Ban{}}

      iex> create_ban(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_ban(Map.t()) :: {:ok, Ban.t()} | {:error, Ecto.Changeset.t()}
  def create_ban(attrs \\ %{}) do
    %Ban{}
    |> Ban.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ban.

  ## Examples

      iex> update_ban(ban, %{field: new_value})
      {:ok, %Ban{}}

      iex> update_ban(ban, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_ban(Ban.t(), Map.t()) :: {:ok, Ban.t()} | {:error, Ecto.Changeset.t()}
  def update_ban(%Ban{} = ban, attrs) do
    ban
    |> Ban.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ban.

  ## Examples

      iex> delete_ban(ban)
      {:ok, %Ban{}}

      iex> delete_ban(ban)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_ban(Ban.t()) :: {:ok, Ban.t()} | {:error, Ecto.Changeset.t()}
  def delete_ban(%Ban{} = ban) do
    Repo.delete(ban)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ban changes.

  ## Examples

      iex> change_ban(ban)
      %Ecto.Changeset{source: %Ban{}}

  """
  @spec change_ban(Ban.t()) :: Ecto.Changeset.t()
  def change_ban(%Ban{} = ban) do
    Ban.changeset(ban, %{})
  end

end