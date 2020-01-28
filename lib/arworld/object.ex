defmodule Arworld.Object do
  @moduledoc """
  The Object context.
  """

  import Ecto.Query, warn: false
  alias Arworld.Repo

  alias Arworld.Object.Objects

  @doc """
  Returns the list of objects.

  ## Examples

      iex> list_objects()
      [%Objects{}, ...]

  """
  def list_objects do
    Repo.all(Objects)
  end

  @doc """
  Gets a single objects.

  Raises `Ecto.NoResultsError` if the Objects does not exist.

  ## Examples

      iex> get_objects!(123)
      %Objects{}

      iex> get_objects!(456)
      ** (Ecto.NoResultsError)

  """
  def get_objects!(id), do: Repo.get!(Objects, id)

  @doc """
  Creates a objects.

  ## Examples

      iex> create_objects(%{field: value})
      {:ok, %Objects{}}

      iex> create_objects(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_objects(attrs \\ %{}) do
    %Objects{}
    |> Objects.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a objects.

  ## Examples

      iex> update_objects(objects, %{field: new_value})
      {:ok, %Objects{}}

      iex> update_objects(objects, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_objects(%Objects{} = objects, attrs) do
    objects
    |> Objects.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a objects.

  ## Examples

      iex> delete_objects(objects)
      {:ok, %Objects{}}

      iex> delete_objects(objects)
      {:error, %Ecto.Changeset{}}

  """
  def delete_objects(%Objects{} = objects) do
    Repo.delete(objects)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking objects changes.

  ## Examples

      iex> change_objects(objects)
      %Ecto.Changeset{source: %Objects{}}

  """
  def change_objects(%Objects{} = objects) do
    Objects.changeset(objects, %{})
  end
end
