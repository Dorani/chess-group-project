class Piece < ApplicationRecord

  belongs_to :game
  
  def self.types
    %w(King Knight Pawn Queen Rook)
  end

  scope :kings, -> { where(type: 'King') }
  scope :knights, -> { where(type: 'Knight') }
  scope :queens, -> { where(type: 'Queen') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :pawns, -> { where(type: 'Pawn') }
  
  def move_to!(x, y)
    return false unless valid_move?(x, y)
    if space_occupied?(x, y)
      return false unless opposing_piece_at_location?(x, y)
      capture!(x, y)
    end
  end

  def piece_at_location(x, y)
    game.pieces.find_by(x_position: x, y_position: y)
  end

  def opposing_piece_at_location?(x, y)
    space_occupied(x, y) && (piece_at_location(x, y).color != color)
  end

  def capture!(piece_at_location)
    update_attributes(x_position: nil, y_position: nil)
  end

  end
