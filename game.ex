defmodule Phanes.Scene.Game do
  use Scenic.Scene
  alias Scenic.Graph
  alias Scenic.ViewPort
  import Scenic.Primitives, only: [text: 3]
  import Scenic.Primitives, only: [rrect: 3, text: 3]

  # Constants
  @graph Graph.build(font: :roboto, font_size: 36)
  @tile_size 25
  @tile_radius 25
  @frame_ms 3000
  @board_width 400
  @board_height 400  #active area only
  @bwc (16 * @tile_size / @board_width) #board_width_conversion
  @bhc (16 * @tile_size / @board_height) #board_height_conversion



  # TO DO LIST
  # This shit is alive....
  # Can I condense ALL of the 'hard coding' to expand it to arbitary size?- i.e 900 (30x30)
  # Approximate time to hard code a 16x16 grid = 5 seconds * 7 * 256 ~ 3 hour :)
  # Approximate time to hard code a 30x30 grid = 5 seconds * 7 * 900 ~ 9 hours :(

  ### doc this for the YT vid, get it on insta and push it out on GitHub and forums...

  # I think I will hard code at 16x16 and call it a day. Then I will take sunday off and move through the rest of this prep phase


  # Initialize the game scene
  def init(_arg, opts) do
    viewport = opts[:viewport]

    # calculate the transform that centers the snake in the viewport
    {:ok, %ViewPort.Status{size: {vp_width, vp_height}}} = ViewPort.info(viewport)

    # start a very simple animation timer
    {:ok, timer} = :timer.send_interval(@frame_ms, :frame)

    board_coord = %{{0,0} => {0 * @bwc, 0 * @bhc}, {1,0} => {1 * @bwc, 0 * @bhc}, {2,0} => {2 * @bwc, 0 * @bhc},
                                                                                                                  {3,0} => {3 * @bwc, 0 * @bhc},
                    {4,0} => {4 * @bwc, 0 * @bhc}, {5,0} => {5 * @bwc, 0 * @bhc}, {6,0} => {6 * @bwc, 0 * @bhc},
                                                                                                                  {7,0} => {7 * @bwc, 0 * @bhc},
                    {8,0} => {8 * @bwc, 0 * @bhc}, {9,0} => {9 * @bwc, 0 * @bhc}, {10,0} => {10 * @bwc, 0 * @bhc},
                                                                                                                  {11,0} => {11 * @bwc, 0 * @bhc},
                    {12,0} => {12 * @bwc, 0 * @bhc}, {13,0} => {13 * @bwc, 0 * @bhc}, {14,0} => {14 * @bwc, 0 * @bhc},
                                                                                                                  {15,0} => {15 * @bwc, 0 * @bhc},

                    {0,1} => {0 * @bwc, 1 * @bhc}, {1,1} => {1 * @bwc, 1 * @bhc}, {2,1} => {2 * @bwc, 1 * @bhc},
                                                                                                                  {3,1} => {3 * @bwc, 1 * @bhc},
                    {4,1} => {4 * @bwc, 1 * @bhc}, {5,1} => {5 * @bwc, 1 * @bhc}, {6,1} => {6 * @bwc, 1 * @bhc},
                                                                                                                  {7,1} => {7 * @bwc, 1 * @bhc},
                    {8,1} => {8 * @bwc, 1 * @bhc}, {9,1} => {9 * @bwc, 1 * @bhc}, {10,1} => {10 * @bwc, 1 * @bhc},
                                                                                                                  {11,1} => {11 * @bwc, 1 * @bhc},
                    {12,1} => {12 * @bwc, 1 * @bhc}, {13,1} => {13 * @bwc, 1 * @bhc}, {14,1} => {14 * @bwc, 1 * @bhc},
                                                                                                                  {15,1} => {15 * @bwc, 1 * @bhc},

                    {0,2} => {0 * @bwc, 2 * @bhc}, {1,2} => {1 * @bwc, 2 * @bhc}, {2,2} => {2 * @bwc, 2 * @bhc},
                                                                                                                  {3,2} => {3 * @bwc, 2 * @bhc},
                    {4,2} => {4 * @bwc, 2 * @bhc}, {5,2} => {5 * @bwc, 2 * @bhc}, {6,2} => {6 * @bwc, 2 * @bhc},
                                                                                                                  {7,2} => {7 * @bwc, 2 * @bhc},
                    {8,2} => {8 * @bwc, 2 * @bhc}, {9,2} => {9 * @bwc, 2 * @bhc}, {10,2} => {10 * @bwc, 2 * @bhc},
                                                                                                                  {11,2} => {11 * @bwc, 2 * @bhc},
                    {12,2} => {12 * @bwc, 2 * @bhc}, {13,2} => {13 * @bwc, 2 * @bhc}, {14,2} => {14 * @bwc, 2 * @bhc},
                                                                                                                  {15,2} => {15 * @bwc, 2 * @bhc},

                    {0,3} => {0 * @bwc, 3 * @bhc}, {1,3} => {1 * @bwc, 3 * @bhc}, {2,3} => {2 * @bwc, 3 * @bhc},
                                                                                                                  {3,3} => {3 * @bwc, 3 * @bhc},
                    {4,3} => {4 * @bwc, 3 * @bhc}, {5,3} => {5 * @bwc, 3 * @bhc}, {6,3} => {6 * @bwc, 3 * @bhc},
                                                                                                                  {7,3} => {7 * @bwc, 3 * @bhc},
                    {8,3} => {8 * @bwc, 3 * @bhc}, {9,3} => {9 * @bwc, 3 * @bhc}, {10,3} => {10 * @bwc, 3 * @bhc},
                                                                                                                  {11,3} => {11 * @bwc, 3 * @bhc},
                    {12,3} => {12 * @bwc, 3 * @bhc}, {13,3} => {13 * @bwc, 3 * @bhc}, {14,3} => {14 * @bwc, 3 * @bhc},
                                                                                                                  {15,3} => {15 * @bwc, 3 * @bhc},

                    {0,4} => {0 * @bwc, 4 * @bhc}, {1,4} => {1 * @bwc, 4 * @bhc}, {2,4} => {2 * @bwc, 4 * @bhc},
                                                                                                                  {3,4} => {3 * @bwc, 4 * @bhc},
                    {4,4} => {4 * @bwc, 4 * @bhc}, {5,4} => {5 * @bwc, 4 * @bhc}, {6,4} => {6 * @bwc, 4 * @bhc},
                                                                                                                  {7,4} => {7 * @bwc, 4 * @bhc},
                    {8,4} => {8 * @bwc, 4 * @bhc}, {9,4} => {9 * @bwc, 4 * @bhc}, {10,4} => {10 * @bwc, 4 * @bhc},
                                                                                                                  {11,4} => {11 * @bwc, 4 * @bhc},
                    {12,4} => {12 * @bwc, 4 * @bhc}, {13,4} => {13 * @bwc, 4 * @bhc}, {14,4} => {14 * @bwc, 4 * @bhc},
                                                                                                                   {15,4} => {15 * @bwc, 4 * @bhc},

                    {0,5} => {0 * @bwc, 5 * @bhc}, {1,5} => {1 * @bwc, 5 * @bhc}, {2,5} => {2 * @bwc, 5 * @bhc},
                                                                                                                   {3,5} => {3 * @bwc, 5 * @bhc},
                    {4,5} => {4 * @bwc, 5 * @bhc}, {5,5} => {5 * @bwc, 5 * @bhc}, {6,5} => {6 * @bwc, 5 * @bhc},
                                                                                                                   {7,5} => {7 * @bwc, 5 * @bhc},
                    {8,5} => {8 * @bwc, 5 * @bhc}, {9,5} => {9 * @bwc, 5 * @bhc}, {10,5} => {10 * @bwc, 5 * @bhc},
                                                                                                                   {11,5} => {11 * @bwc, 5 * @bhc},
                    {12,5} => {12 * @bwc, 5 * @bhc}, {13,5} => {13 * @bwc, 5 * @bhc}, {14,5} => {14 * @bwc, 5 * @bhc},
                                                                                                                   {15,5} => {15 * @bwc, 5 * @bhc},

                    {0,6} => {0 * @bwc, 6 * @bhc}, {1,6} => {1 * @bwc, 6 * @bhc}, {2,6} => {2 * @bwc, 6 * @bhc},
                                                                                                                   {3,6} => {3 * @bwc, 6 * @bhc},
                    {4,6} => {4 * @bwc, 6 * @bhc}, {5,6} => {5 * @bwc, 6 * @bhc}, {6,6} => {6 * @bwc, 6 * @bhc},
                                                                                                                   {7,6} => {7 * @bwc, 6 * @bhc},
                    {8,6} => {8 * @bwc, 6 * @bhc}, {9,6} => {9 * @bwc, 6 * @bhc}, {10,6} => {10 * @bwc, 6 * @bhc},
                                                                                                                   {11,6} => {11 * @bwc, 6 * @bhc},
                    {12,6} => {12 * @bwc, 6 * @bhc}, {13,6} => {13 * @bwc, 6 * @bhc}, {14,6} => {14 * @bwc, 6 * @bhc},
                                                                                                                   {15,6} => {15 * @bwc, 6 * @bhc},

                    {0,7} => {0 * @bwc, 7 * @bhc}, {1,7} => {1 * @bwc, 7 * @bhc}, {2,7} => {2 * @bwc, 7 * @bhc},
                                                                                                                   {3,7} => {3 * @bwc, 7 * @bhc},
                    {4,7} => {4 * @bwc, 7 * @bhc}, {5,7} => {5 * @bwc, 7 * @bhc}, {6,7} => {6 * @bwc, 7 * @bhc},
                                                                                                                   {7,7} => {7 * @bwc, 7 * @bhc},
                    {8,7} => {8 * @bwc, 7 * @bhc}, {9,7} => {9 * @bwc, 7 * @bhc}, {10,7} => {10 * @bwc, 7 * @bhc},
                                                                                                                   {11,7} => {11 * @bwc, 7 * @bhc},
                    {12,7} => {12 * @bwc, 7 * @bhc}, {13,7} => {13 * @bwc, 7 * @bhc}, {14,7} => {14 * @bwc, 7 * @bhc},
                                                                                                                   {15,7} => {15 * @bwc, 7 * @bhc},

                    {0,8} => {0 * @bwc, 8 * @bhc}, {1,8} => {1 * @bwc, 8 * @bhc}, {2,8} => {2 * @bwc, 8 * @bhc},
                                                                                                                   {3,8} => {3 * @bwc, 8 * @bhc},
                    {4,8} => {4 * @bwc, 8 * @bhc}, {5,8} => {5 * @bwc, 8 * @bhc}, {6,8} => {6 * @bwc, 8 * @bhc},
                                                                                                                   {7,8} => {7 * @bwc, 8 * @bhc},
                    {8,8} => {8 * @bwc, 8 * @bhc}, {9,8} => {9 * @bwc, 8 * @bhc}, {10,8} => {10 * @bwc, 8 * @bhc},
                                                                                                                   {11,8} => {11 * @bwc, 8 * @bhc},
                    {12,8} => {12 * @bwc, 8 * @bhc}, {13,8} => {13 * @bwc, 8 * @bhc}, {14,8} => {14 * @bwc, 8 * @bhc},
                                                                                                                   {15,8} => {15 * @bwc, 8 * @bhc},

                    {0,9} => {0 * @bwc, 9 * @bhc}, {1,9} => {1 * @bwc, 9 * @bhc}, {2,9} => {2 * @bwc, 9 * @bhc},
                                                                                                                   {3,9} => {3 * @bwc, 9 * @bhc},
                    {4,9} => {4 * @bwc, 9 * @bhc}, {5,9} => {5 * @bwc, 9 * @bhc}, {6,9} => {6 * @bwc, 9 * @bhc},
                                                                                                                   {7,9} => {7 * @bwc, 9 * @bhc},
                    {8,9} => {8 * @bwc, 9 * @bhc}, {9,9} => {9 * @bwc, 9 * @bhc}, {10,9} => {10 * @bwc, 9 * @bhc},
                                                                                                                   {11,9} => {11 * @bwc, 9 * @bhc},
                    {12,9} => {12 * @bwc, 9 * @bhc}, {13,9} => {13 * @bwc, 9 * @bhc}, {14,9} => {14 * @bwc, 9 * @bhc},
                                                                                                                   {15,9} => {15 * @bwc, 9 * @bhc},

                    {0,10} => {0 * @bwc, 10 * @bhc}, {1,10} => {1 * @bwc, 10 * @bhc}, {2,10} => {2 * @bwc, 10 * @bhc},
                                                                                                                   {3,10} => {3 * @bwc, 10 * @bhc},
                    {4,10} => {4 * @bwc, 10 * @bhc}, {5,10} => {5 * @bwc, 10 * @bhc}, {6,10} => {6 * @bwc, 10 * @bhc},
                                                                                                                   {7,10} => {7 * @bwc, 10 * @bhc},
                    {8,10} => {8 * @bwc, 10 * @bhc}, {9,10} => {9 * @bwc, 10 * @bhc}, {10,10} => {10 * @bwc, 10 * @bhc},
                                                                                                                   {11,10} => {11 * @bwc, 10 * @bhc},
                    {12,10} => {12 * @bwc, 10 * @bhc}, {13,10} => {13 * @bwc, 10 * @bhc}, {14,10} => {14 * @bwc, 10 * @bhc},
                                                                                                                   {15,10} => {15 * @bwc, 10 * @bhc},

                    {0,11} => {0 * @bwc, 11 * @bhc}, {1,11} => {1 * @bwc, 11 * @bhc}, {2,11} => {2 * @bwc, 11 * @bhc},
                                                                                                                   {3,11} => {3 * @bwc, 11 * @bhc},
                    {4,11} => {4 * @bwc, 11 * @bhc}, {5,11} => {5 * @bwc, 11 * @bhc}, {6,11} => {6 * @bwc, 11 * @bhc},
                                                                                                                   {7,11} => {7 * @bwc, 11 * @bhc},
                    {8,11} => {8 * @bwc, 11 * @bhc}, {9,11} => {9 * @bwc, 11 * @bhc}, {10,11} => {10 * @bwc, 11 * @bhc},
                                                                                                                   {11,11} => {11 * @bwc, 11 * @bhc},
                    {12,11} => {12 * @bwc, 11 * @bhc}, {13,11} => {13 * @bwc, 11 * @bhc}, {14,11} => {14 * @bwc, 11 * @bhc},
                                                                                                                   {15,11} => {15 * @bwc, 11 * @bhc},

                    {0,12} => {0 * @bwc, 12 * @bhc}, {1,12} => {1 * @bwc, 12 * @bhc}, {2,12} => {2 * @bwc, 12 * @bhc},
                                                                                                                   {3,12} => {3 * @bwc, 12 * @bhc},
                    {4,12} => {4 * @bwc, 12 * @bhc}, {5,12} => {5 * @bwc, 12 * @bhc}, {6,12} => {6 * @bwc, 12 * @bhc},
                                                                                                                   {7,12} => {7 * @bwc, 12 * @bhc},
                    {8,12} => {8 * @bwc, 12 * @bhc}, {9,12} => {9 * @bwc, 12 * @bhc}, {10,12} => {10 * @bwc, 12 * @bhc},
                                                                                                                   {11,12} => {11 * @bwc, 12 * @bhc},
                    {12,12} => {12 * @bwc, 12 * @bhc}, {13,12} => {13 * @bwc, 12 * @bhc}, {14,12} => {14 * @bwc, 12 * @bhc},
                                                                                                                   {15,12} => {15 * @bwc, 12 * @bhc},

                    {0,13} => {0 * @bwc, 13 * @bhc}, {1,13} => {1 * @bwc, 13 * @bhc}, {2,13} => {2 * @bwc, 13 * @bhc},
                                                                                                                   {3,13} => {3 * @bwc, 13 * @bhc},
                    {4,13} => {4 * @bwc, 13 * @bhc}, {5,13} => {5 * @bwc, 13 * @bhc}, {6,13} => {6 * @bwc, 13 * @bhc},
                                                                                                                   {7,13} => {7 * @bwc, 13 * @bhc},
                    {8,13} => {8 * @bwc, 13 * @bhc}, {9,13} => {9 * @bwc, 13 * @bhc}, {10,13} => {10 * @bwc, 13 * @bhc},
                                                                                                                   {11,13} => {11 * @bwc, 13 * @bhc},
                    {12,13} => {12 * @bwc, 13 * @bhc}, {13,13} => {13 * @bwc, 13 * @bhc}, {14,13} => {14 * @bwc, 13 * @bhc},
                                                                                                                   {15,13} => {15 * @bwc, 13 * @bhc},

                    {0,14} => {0 * @bwc, 14 * @bhc}, {1,14} => {1 * @bwc, 14 * @bhc}, {2,14} => {2 * @bwc, 14 * @bhc},
                                                                                                                   {3,14} => {3 * @bwc, 14 * @bhc},
                    {4,14} => {4 * @bwc, 14 * @bhc}, {5,14} => {5 * @bwc, 14 * @bhc}, {6,14} => {6 * @bwc, 14 * @bhc},
                                                                                                                   {7,14} => {7 * @bwc, 14 * @bhc},
                    {8,14} => {8 * @bwc, 14 * @bhc}, {9,14} => {9 * @bwc, 14 * @bhc}, {10,14} => {10 * @bwc, 14 * @bhc},
                                                                                                                   {11,14} => {11 * @bwc, 14 * @bhc},
                    {12,14} => {12 * @bwc, 14 * @bhc}, {13,14} => {13 * @bwc, 14 * @bhc}, {14,14} => {14 * @bwc, 14 * @bhc},
                                                                                                                   {15,14} => {15 * @bwc, 14 * @bhc},

                    {0,15} => {0 * @bwc, 15 * @bhc}, {1,15} => {1 * @bwc, 15 * @bhc}, {2,15} => {2 * @bwc, 15 * @bhc},
                                                                                                                   {3,15} => {3 * @bwc, 15 * @bhc},
                    {4,15} => {4 * @bwc, 15 * @bhc}, {5,15} => {5 * @bwc, 15 * @bhc}, {6,15} => {6 * @bwc, 15 * @bhc},
                                                                                                                   {7,15} => {7 * @bwc, 15 * @bhc},
                    {8,15} => {8 * @bwc, 15 * @bhc}, {9,15} => {9 * @bwc, 15 * @bhc}, {10,15} => {10 * @bwc, 15 * @bhc},
                                                                                                                   {11,15} => {11 * @bwc, 15 * @bhc},
                    {12,15} => {12 * @bwc, 15 * @bhc}, {13,15} => {13 * @bwc, 15 * @bhc}, {14,15} => {14 * @bwc, 15 * @bhc},
                                                                                                                   {15,15} => {15 * @bwc, 15 * @bhc}
                  }



    # The entire game state will be held here
    state = %{

      viewport: viewport,
      graph: @graph,
      frame_count: 1,
      frame_timer: timer,
      generation: 0,
      objects: %{
                 cell_0: %{cell: 0, coord: board_coord[{0,0}]},
                 cell_1: %{cell: 0, coord: board_coord[{1,0}]},
                 cell_2: %{cell: 0, coord: board_coord[{2,0}]},
                 cell_3: %{cell: 0, coord: board_coord[{3,0}]},
                 cell_4: %{cell: 0, coord: board_coord[{4,0}]},
                 cell_5: %{cell: 0, coord: board_coord[{5,0}]},
                 cell_6: %{cell: 0, coord: board_coord[{6,0}]},
                 cell_7: %{cell: 0, coord: board_coord[{7,0}]},
                 cell_8: %{cell: 0, coord: board_coord[{8,0}]},
                 cell_9: %{cell: 0, coord: board_coord[{9,0}]},
                 cell_10: %{cell: 0, coord: board_coord[{10,0}]},
                 cell_11: %{cell: 0, coord: board_coord[{11,0}]},
                 cell_12: %{cell: 0, coord: board_coord[{12,0}]},
                 cell_13: %{cell: 0, coord: board_coord[{13,0}]},
                 cell_14: %{cell: 0, coord: board_coord[{14,0}]},
                 cell_15: %{cell: 0, coord: board_coord[{15,0}]},

                 cell_16: %{cell: 0, coord: board_coord[{0,1}]},
                 cell_17: %{cell: 0, coord: board_coord[{1,1}]},
                 cell_18: %{cell: 0, coord: board_coord[{2,1}]},
                 cell_19: %{cell: 0, coord: board_coord[{3,1}]},
                 cell_20: %{cell: 0, coord: board_coord[{4,1}]},
                 cell_21: %{cell: 0, coord: board_coord[{5,1}]},
                 cell_22: %{cell: 0, coord: board_coord[{6,1}]},
                 cell_23: %{cell: 0, coord: board_coord[{7,1}]},
                 cell_24: %{cell: 0, coord: board_coord[{8,1}]},
                 cell_25: %{cell: 0, coord: board_coord[{9,1}]},
                 cell_26: %{cell: 0, coord: board_coord[{10,1}]},
                 cell_27: %{cell: 0, coord: board_coord[{11,1}]},
                 cell_28: %{cell: 0, coord: board_coord[{12,1}]},
                 cell_29: %{cell: 0, coord: board_coord[{13,1}]},
                 cell_30: %{cell: 0, coord: board_coord[{14,1}]},
                 cell_31: %{cell: 0, coord: board_coord[{15,1}]},

                 cell_32: %{cell: 0, coord: board_coord[{0,2}]},
                 cell_33: %{cell: 0, coord: board_coord[{1,2}]},
                 cell_34: %{cell: 0, coord: board_coord[{2,2}]},
                 cell_35: %{cell: 0, coord: board_coord[{3,2}]},
                 cell_36: %{cell: 0, coord: board_coord[{4,2}]},
                 cell_37: %{cell: 0, coord: board_coord[{5,2}]},
                 cell_38: %{cell: 0, coord: board_coord[{6,2}]},
                 cell_39: %{cell: 0, coord: board_coord[{7,2}]},
                 cell_40: %{cell: 0, coord: board_coord[{8,2}]},
                 cell_41: %{cell: 0, coord: board_coord[{9,2}]},
                 cell_42: %{cell: 0, coord: board_coord[{10,2}]},
                 cell_43: %{cell: 0, coord: board_coord[{11,2}]},
                 cell_44: %{cell: 0, coord: board_coord[{12,2}]},
                 cell_45: %{cell: 0, coord: board_coord[{13,2}]},
                 cell_46: %{cell: 0, coord: board_coord[{14,2}]},
                 cell_47: %{cell: 0, coord: board_coord[{15,2}]},

                 cell_48: %{cell: 0, coord: board_coord[{0,3}]},
                 cell_49: %{cell: 0, coord: board_coord[{1,3}]},
                 cell_50: %{cell: 0, coord: board_coord[{2,3}]},
                 cell_51: %{cell: 0, coord: board_coord[{3,3}]},
                 cell_52: %{cell: 0, coord: board_coord[{4,3}]},
                 cell_53: %{cell: 0, coord: board_coord[{5,3}]},
                 cell_54: %{cell: 0, coord: board_coord[{6,3}]},
                 cell_55: %{cell: 0, coord: board_coord[{7,3}]},
                 cell_56: %{cell: 0, coord: board_coord[{8,3}]},
                 cell_57: %{cell: 0, coord: board_coord[{9,3}]},
                 cell_58: %{cell: 0, coord: board_coord[{10,3}]},
                 cell_59: %{cell: 0, coord: board_coord[{11,3}]},
                 cell_60: %{cell: 0, coord: board_coord[{12,3}]},
                 cell_61: %{cell: 0, coord: board_coord[{13,3}]},
                 cell_62: %{cell: 0, coord: board_coord[{14,3}]},
                 cell_63: %{cell: 0, coord: board_coord[{15,3}]},

                 cell_64: %{cell: 0, coord: board_coord[{0,4}]},
                 cell_65: %{cell: 0, coord: board_coord[{1,4}]},
                 cell_66: %{cell: 0, coord: board_coord[{2,4}]},
                 cell_67: %{cell: 0, coord: board_coord[{3,4}]},
                 cell_68: %{cell: 0, coord: board_coord[{4,4}]},
                 cell_69: %{cell: 0, coord: board_coord[{5,4}]},
                 cell_70: %{cell: 0, coord: board_coord[{6,4}]},
                 cell_71: %{cell: 0, coord: board_coord[{7,4}]},
                 cell_72: %{cell: 0, coord: board_coord[{8,4}]},
                 cell_73: %{cell: 0, coord: board_coord[{9,4}]},
                 cell_74: %{cell: 0, coord: board_coord[{10,4}]},
                 cell_75: %{cell: 0, coord: board_coord[{11,4}]},
                 cell_76: %{cell: 0, coord: board_coord[{12,4}]},
                 cell_77: %{cell: 0, coord: board_coord[{13,4}]},
                 cell_78: %{cell: 0, coord: board_coord[{14,4}]},
                 cell_79: %{cell: 0, coord: board_coord[{15,4}]},

                 cell_80: %{cell: 0, coord: board_coord[{0,5}]},
                 cell_81: %{cell: 0, coord: board_coord[{1,5}]},
                 cell_82: %{cell: 0, coord: board_coord[{2,5}]},
                 cell_83: %{cell: 0, coord: board_coord[{3,5}]},
                 cell_84: %{cell: 0, coord: board_coord[{4,5}]},
                 cell_85: %{cell: 0, coord: board_coord[{5,5}]},
                 cell_86: %{cell: 0, coord: board_coord[{6,5}]},
                 cell_87: %{cell: 0, coord: board_coord[{7,5}]},
                 cell_88: %{cell: 0, coord: board_coord[{8,5}]},
                 cell_89: %{cell: 0, coord: board_coord[{9,5}]},
                 cell_90: %{cell: 0, coord: board_coord[{10,5}]},
                 cell_91: %{cell: 0, coord: board_coord[{11,5}]},
                 cell_92: %{cell: 0, coord: board_coord[{12,5}]},
                 cell_93: %{cell: 0, coord: board_coord[{13,5}]},
                 cell_94: %{cell: 0, coord: board_coord[{14,5}]},
                 cell_95: %{cell: 0, coord: board_coord[{15,5}]},

                 cell_96: %{cell: 0, coord: board_coord[{0,6}]},
                 cell_97: %{cell: 0, coord: board_coord[{1,6}]},
                 cell_98: %{cell: 0, coord: board_coord[{2,6}]},
                 cell_99: %{cell: 0, coord: board_coord[{3,6}]},
                 cell_100: %{cell: 0, coord: board_coord[{4,6}]},
                 cell_101: %{cell: 0, coord: board_coord[{5,6}]},
                 cell_102: %{cell: 0, coord: board_coord[{6,6}]},
                 cell_103: %{cell: 0, coord: board_coord[{7,6}]},
                 cell_104: %{cell: 0, coord: board_coord[{8,6}]},
                 cell_105: %{cell: 0, coord: board_coord[{9,6}]},
                 cell_106: %{cell: 0, coord: board_coord[{10,6}]},
                 cell_107: %{cell: 0, coord: board_coord[{11,6}]},
                 cell_108: %{cell: 0, coord: board_coord[{12,6}]},
                 cell_109: %{cell: 0, coord: board_coord[{13,6}]},
                 cell_110: %{cell: 0, coord: board_coord[{14,6}]},
                 cell_111: %{cell: 0, coord: board_coord[{15,6}]},

                 cell_112: %{cell: 0, coord: board_coord[{0,7}]},
                 cell_113: %{cell: 0, coord: board_coord[{1,7}]},
                 cell_114: %{cell: 0, coord: board_coord[{2,7}]},
                 cell_115: %{cell: 0, coord: board_coord[{3,7}]},
                 cell_116: %{cell: 0, coord: board_coord[{4,7}]},
                 cell_117: %{cell: 0, coord: board_coord[{5,7}]},
                 cell_118: %{cell: 0, coord: board_coord[{6,7}]},
                 cell_119: %{cell: 0, coord: board_coord[{7,7}]},
                 cell_120: %{cell: 0, coord: board_coord[{8,7}]},
                 cell_121: %{cell: 0, coord: board_coord[{9,7}]},
                 cell_122: %{cell: 0, coord: board_coord[{10,7}]},
                 cell_123: %{cell: 0, coord: board_coord[{11,7}]},
                 cell_124: %{cell: 0, coord: board_coord[{12,7}]},
                 cell_125: %{cell: 0, coord: board_coord[{13,7}]},
                 cell_126: %{cell: 0, coord: board_coord[{14,7}]},
                 cell_127: %{cell: 0, coord: board_coord[{15,7}]},

                 cell_128: %{cell: 0, coord: board_coord[{0,8}]},
                 cell_129: %{cell: 0, coord: board_coord[{1,8}]},
                 cell_130: %{cell: 0, coord: board_coord[{2,8}]},
                 cell_131: %{cell: 0, coord: board_coord[{3,8}]},
                 cell_132: %{cell: 0, coord: board_coord[{4,8}]},
                 cell_133: %{cell: 0, coord: board_coord[{5,8}]},
                 cell_134: %{cell: 0, coord: board_coord[{6,8}]},
                 cell_135: %{cell: 0, coord: board_coord[{7,8}]},
                 cell_136: %{cell: 0, coord: board_coord[{8,8}]},
                 cell_137: %{cell: 0, coord: board_coord[{9,8}]},
                 cell_138: %{cell: 0, coord: board_coord[{10,8}]},
                 cell_139: %{cell: 0, coord: board_coord[{11,8}]},
                 cell_140: %{cell: 0, coord: board_coord[{12,8}]},
                 cell_141: %{cell: 0, coord: board_coord[{13,8}]},
                 cell_142: %{cell: 0, coord: board_coord[{14,8}]},
                 cell_143: %{cell: 0, coord: board_coord[{15,8}]},

                 cell_144: %{cell: 0, coord: board_coord[{0,9}]},
                 cell_145: %{cell: 0, coord: board_coord[{1,9}]},
                 cell_146: %{cell: 0, coord: board_coord[{2,9}]},
                 cell_147: %{cell: 0, coord: board_coord[{3,9}]},
                 cell_148: %{cell: 0, coord: board_coord[{4,9}]},
                 cell_149: %{cell: 0, coord: board_coord[{5,9}]},
                 cell_150: %{cell: 0, coord: board_coord[{6,9}]},
                 cell_151: %{cell: 0, coord: board_coord[{7,9}]},
                 cell_152: %{cell: 0, coord: board_coord[{8,9}]},
                 cell_153: %{cell: 0, coord: board_coord[{9,9}]},
                 cell_154: %{cell: 0, coord: board_coord[{10,9}]},
                 cell_155: %{cell: 0, coord: board_coord[{11,9}]},
                 cell_156: %{cell: 0, coord: board_coord[{12,9}]},
                 cell_157: %{cell: 0, coord: board_coord[{13,9}]},
                 cell_158: %{cell: 0, coord: board_coord[{14,9}]},
                 cell_159: %{cell: 0, coord: board_coord[{15,9}]},

                 cell_160: %{cell: 0, coord: board_coord[{0,10}]},
                 cell_161: %{cell: 0, coord: board_coord[{1,10}]},
                 cell_162: %{cell: 0, coord: board_coord[{2,10}]},
                 cell_163: %{cell: 0, coord: board_coord[{3,10}]},
                 cell_164: %{cell: 0, coord: board_coord[{4,10}]},
                 cell_165: %{cell: 0, coord: board_coord[{5,10}]},
                 cell_166: %{cell: 0, coord: board_coord[{6,10}]},
                 cell_167: %{cell: 0, coord: board_coord[{7,10}]},
                 cell_168: %{cell: 0, coord: board_coord[{8,10}]},
                 cell_169: %{cell: 0, coord: board_coord[{9,10}]},
                 cell_170: %{cell: 0, coord: board_coord[{10,10}]},
                 cell_171: %{cell: 0, coord: board_coord[{11,10}]},
                 cell_172: %{cell: 0, coord: board_coord[{12,10}]},
                 cell_173: %{cell: 0, coord: board_coord[{13,10}]},
                 cell_174: %{cell: 0, coord: board_coord[{14,10}]},
                 cell_175: %{cell: 0, coord: board_coord[{15,10}]},

                 cell_176: %{cell: 0, coord: board_coord[{0,11}]},
                 cell_177: %{cell: 0, coord: board_coord[{1,11}]},
                 cell_178: %{cell: 0, coord: board_coord[{2,11}]},
                 cell_179: %{cell: 0, coord: board_coord[{3,11}]},
                 cell_180: %{cell: 0, coord: board_coord[{4,11}]},
                 cell_181: %{cell: 0, coord: board_coord[{5,11}]},
                 cell_182: %{cell: 0, coord: board_coord[{6,11}]},
                 cell_183: %{cell: 0, coord: board_coord[{7,11}]},
                 cell_184: %{cell: 0, coord: board_coord[{8,11}]},
                 cell_185: %{cell: 0, coord: board_coord[{9,11}]},
                 cell_186: %{cell: 0, coord: board_coord[{10,11}]},
                 cell_187: %{cell: 0, coord: board_coord[{11,11}]},
                 cell_188: %{cell: 0, coord: board_coord[{12,11}]},
                 cell_189: %{cell: 0, coord: board_coord[{13,11}]},
                 cell_190: %{cell: 0, coord: board_coord[{14,11}]},
                 cell_191: %{cell: 0, coord: board_coord[{15,11}]},

                 cell_192: %{cell: 0, coord: board_coord[{0,12}]},
                 cell_193: %{cell: 0, coord: board_coord[{1,12}]},
                 cell_194: %{cell: 0, coord: board_coord[{2,12}]},
                 cell_195: %{cell: 0, coord: board_coord[{3,12}]},
                 cell_196: %{cell: 0, coord: board_coord[{4,12}]},
                 cell_197: %{cell: 0, coord: board_coord[{5,12}]},
                 cell_198: %{cell: 0, coord: board_coord[{6,12}]},
                 cell_199: %{cell: 0, coord: board_coord[{7,12}]},
                 cell_200: %{cell: 0, coord: board_coord[{8,12}]},
                 cell_201: %{cell: 0, coord: board_coord[{9,12}]},
                 cell_202: %{cell: 0, coord: board_coord[{10,12}]},
                 cell_203: %{cell: 0, coord: board_coord[{11,12}]},
                 cell_204: %{cell: 0, coord: board_coord[{12,12}]},
                 cell_205: %{cell: 0, coord: board_coord[{13,12}]},
                 cell_206: %{cell: 0, coord: board_coord[{14,12}]},
                 cell_207: %{cell: 0, coord: board_coord[{15,12}]},

                 cell_208: %{cell: 0, coord: board_coord[{0,13}]},
                 cell_209: %{cell: 0, coord: board_coord[{1,13}]},
                 cell_210: %{cell: 0, coord: board_coord[{2,13}]},
                 cell_211: %{cell: 0, coord: board_coord[{3,13}]},
                 cell_212: %{cell: 0, coord: board_coord[{4,13}]},
                 cell_213: %{cell: 0, coord: board_coord[{5,13}]},
                 cell_214: %{cell: 0, coord: board_coord[{6,13}]},
                 cell_215: %{cell: 0, coord: board_coord[{7,13}]},
                 cell_216: %{cell: 0, coord: board_coord[{8,13}]},
                 cell_217: %{cell: 0, coord: board_coord[{9,13}]},
                 cell_218: %{cell: 0, coord: board_coord[{10,13}]},
                 cell_219: %{cell: 0, coord: board_coord[{11,13}]},
                 cell_220: %{cell: 0, coord: board_coord[{12,13}]},
                 cell_221: %{cell: 0, coord: board_coord[{13,13}]},
                 cell_222: %{cell: 0, coord: board_coord[{14,13}]},
                 cell_223: %{cell: 0, coord: board_coord[{15,13}]},

                 cell_224: %{cell: 0, coord: board_coord[{0,14}]},
                 cell_225: %{cell: 0, coord: board_coord[{1,14}]},
                 cell_226: %{cell: 0, coord: board_coord[{2,14}]},
                 cell_227: %{cell: 0, coord: board_coord[{3,14}]},
                 cell_228: %{cell: 0, coord: board_coord[{4,14}]},
                 cell_229: %{cell: 0, coord: board_coord[{5,14}]},
                 cell_230: %{cell: 0, coord: board_coord[{6,14}]},
                 cell_231: %{cell: 0, coord: board_coord[{7,14}]},
                 cell_232: %{cell: 0, coord: board_coord[{8,14}]},
                 cell_233: %{cell: 0, coord: board_coord[{9,14}]},
                 cell_234: %{cell: 0, coord: board_coord[{10,14}]},
                 cell_235: %{cell: 0, coord: board_coord[{11,14}]},
                 cell_236: %{cell: 0, coord: board_coord[{12,14}]},
                 cell_237: %{cell: 0, coord: board_coord[{13,14}]},
                 cell_238: %{cell: 0, coord: board_coord[{14,14}]},
                 cell_239: %{cell: 0, coord: board_coord[{15,14}]},

                 cell_240: %{cell: 0, coord: board_coord[{0,15}]},
                 cell_241: %{cell: 0, coord: board_coord[{1,15}]},
                 cell_242: %{cell: 0, coord: board_coord[{2,15}]},
                 cell_243: %{cell: 0, coord: board_coord[{3,15}]},
                 cell_244: %{cell: 0, coord: board_coord[{4,15}]},
                 cell_245: %{cell: 0, coord: board_coord[{5,15}]},
                 cell_246: %{cell: 0, coord: board_coord[{6,15}]},
                 cell_247: %{cell: 0, coord: board_coord[{7,15}]},
                 cell_248: %{cell: 0, coord: board_coord[{8,15}]},
                 cell_249: %{cell: 0, coord: board_coord[{9,15}]},
                 cell_250: %{cell: 0, coord: board_coord[{10,15}]},
                 cell_251: %{cell: 0, coord: board_coord[{11,15}]},
                 cell_252: %{cell: 0, coord: board_coord[{12,15}]},
                 cell_253: %{cell: 0, coord: board_coord[{13,15}]},
                 cell_254: %{cell: 0, coord: board_coord[{14,15}]},
                 cell_255: %{cell: 0, coord: board_coord[{15,15}]}

                }
      }


      # Update the graph and push it to be rendered
      state.graph
      |> draw_generation(state.generation)
      |> draw_game_objects(state.objects, state.generation)
      |> push_graph()

      {:ok, state}
    end

    # Draw the generation number
    defp draw_generation(graph, generation) do
      graph
      |> text("generation   -   #{generation}", fill: :white, font_size: 20, translate: {20, 475})
    end

    # Iterates over the object map, rendering each object
    defp draw_game_objects(graph, object_map, generation) do
      Enum.reduce(object_map, graph, fn {object_type, object_data}, graph ->
          draw_object(graph, object_type, object_data, generation)
      end)
    end


    # Draw tiles as rounded rectangles to look nice
    defp draw_tile(graph, x, y, opts) do
      tile_opts = Keyword.merge([fill: :white, translate: {x * @tile_size, y * @tile_size}], opts)
      graph |> rrect({@tile_size * 0.9, @tile_size * 0.9, @tile_radius}, tile_opts)
    end

    def handle_info(:frame, %{frame_count: frame_count} = state) do
        #state = move_snake(state)

        state.graph
        |> draw_generation(state.frame_count)
        |> draw_game_objects(state.objects, state.frame_count)
        |> push_graph()



        {:noreply, %{state | frame_count: frame_count + 1}}

    end






  # Fingers crossed we can draw this bloody map
  defp draw_object(graph, :cell_0, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_0)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_0)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_1, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_1)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_1)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_2, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_2)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_2)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_3, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_3)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_3)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_4, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_4)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_4)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_5, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_5)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_5)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_6, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_6)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_6)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_7, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_7)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_7)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_8, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_8)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_8)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_9, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_9)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_9)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_10, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_10)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_10)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_11, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_11)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_11)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_12, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_12)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_12)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_13, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_13)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_13)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_14, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_14)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_14)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_15, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,0}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_15)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_15)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_16, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_16)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_16)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_17, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_17)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_17)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_18, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_18)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_18)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_19, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_19)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_19)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_20, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_20)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_20)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_21, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_21)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_21)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_22, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_22)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_22)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_23, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_23)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_23)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_24, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_24)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_24)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_25, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_25)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_25)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_26, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_26)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_26)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_27, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_27)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_27)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_28, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_28)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_28)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_29, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_29)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_29)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_30, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_30)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_30)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_31, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,1}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_31)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_31)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end










  defp draw_object(graph, :cell_32, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_32)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_32)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_33, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_33)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_33)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_34, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_34)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_34)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_35, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_35)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_35)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_36, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_36)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_36)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_37, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_37)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_37)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_38, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_38)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_38)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_39, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_39)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_39)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_40, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_40)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_40)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_41, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_41)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_41)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_42, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_42)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_42)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_43, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_43)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_43)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_44, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_44)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_44)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_45, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_45)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_45)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_46, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_46)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_46)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_47, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,2}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_47)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_47)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_48, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_48)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_48)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_49, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_49)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_49)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_50, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_50)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_50)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_51, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_51)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_51)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_52, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_52)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_52)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_53, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_53)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_53)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_54, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_54)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_54)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_55, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_55)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_55)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_56, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_56)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_56)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_57, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_57)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_57)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_58, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_58)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_58)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_59, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_59)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_59)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_60, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_60)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_60)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_61, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_61)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_61)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_62, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_62)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_62)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_63, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,3}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_63)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_63)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end










  defp draw_object(graph, :cell_64, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_64)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_64)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_65, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_65)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_65)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_66, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_66)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_66)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_67, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_67)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_67)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_68, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_68)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_68)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_69, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_69)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_69)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_70, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_70)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_70)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_71, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_71)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_71)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_72, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_72)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_72)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_73, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_73)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_73)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_74, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_74)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_74)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_75, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_75)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_75)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_76, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_76)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_76)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_77, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_77)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_77)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_78, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_78)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_78)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_79, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,4}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_79)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_79)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end








  defp draw_object(graph, :cell_80, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_80)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_80)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_81, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_81)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_81)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_82, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_82)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_82)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_83, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_83)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_83)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_84, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_84)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_84)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_85, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_85)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_85)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_86, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_86)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_86)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_87, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_87)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_87)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_88, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_88)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_88)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_89, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_89)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_89)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_90, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_90)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_90)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_91, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_91)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_91)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_92, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_92)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_92)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_93, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_93)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_93)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_94, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_94)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_94)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_95, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,5}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_95)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_95)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end








  defp draw_object(graph, :cell_96, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_96)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_96)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_97, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_97)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_97)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_98, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_98)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_98)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_99, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_99)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_99)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_100, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_100)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_100)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_101, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_101)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_101)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_102, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_102)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_102)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_103, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_103)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_103)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_104, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_104)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_104)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_105, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_105)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_105)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_106, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_106)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_106)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_107, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_107)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_107)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_108, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_108)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_108)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_109, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_109)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_109)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_110, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_110)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_110)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_111, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,6}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_111)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_111)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_112, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_112)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_112)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_113, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_113)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_113)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_114, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_114)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_114)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_115, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_115)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_115)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_116, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_116)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_116)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_117, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_117)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_117)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_118, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_118)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_118)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_119, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_119)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_119)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_120, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_120)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_120)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_121, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_121)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_121)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_122, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_122)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_122)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_123, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_123)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_123)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_124, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_124)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_124)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_125, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_125)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_125)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_126, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_126)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_126)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_127, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,7}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_127)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_127)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_128, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_128)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_128)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_129, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_129)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_129)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_130, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_130)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_130)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_131, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_131)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_131)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_132, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_132)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_132)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_133, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_133)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_133)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_134, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_134)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_134)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_135, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_135)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_135)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_136, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_136)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_136)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_137, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_137)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_137)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_138, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_138)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_138)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_139, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_139)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_139)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_140, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_140)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_140)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end


  defp draw_object(graph, :cell_141, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_141)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_141)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_142, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_142)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_142)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_143, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,8}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_143)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_143)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end











  defp draw_object(graph, :cell_144, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_144)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_144)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_145, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_145)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_145)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_146, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_146)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_146)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end


  defp draw_object(graph, :cell_147, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_147)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_147)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_148, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_148)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_148)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_149, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_149)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_149)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_150, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_150)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_150)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_151, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_151)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_151)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_152, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_152)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_152)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_153, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_153)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_153)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_154, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_154)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_154)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_155, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_155)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_155)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_156, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_156)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_156)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_157, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_157)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_157)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_158, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_158)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_158)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_159, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,9}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_159)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_159)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end













  defp draw_object(graph, :cell_160, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_160)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_160)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_161, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_161)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_161)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_162, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_162)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_162)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_163, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_163)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_163)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_164, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_164)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_164)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_165, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_165)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_165)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_166, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_166)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_166)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_167, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_167)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_167)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_168, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_168)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_168)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_169, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_169)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_169)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_170, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_170)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_170)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_171, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_171)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_171)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_172, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_172)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_172)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_173, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_173)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_173)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_174, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_174)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_174)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_175, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,10}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_175)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_175)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_176, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_176)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_176)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_177, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_177)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_177)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_178, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_178)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_178)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_179, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_179)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_179)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_180, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_180)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_180)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_181, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_181)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_181)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_182, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_182)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_182)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_183, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_183)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_183)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_184, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_184)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_184)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_185, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_185)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_185)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_186, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_186)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_186)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_187, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_187)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_187)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_188, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_188)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_188)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_189, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_189)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_189)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_190, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_190)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_190)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_191, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,11}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_191)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_191)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end









  defp draw_object(graph, :cell_192, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_192)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_192)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_193, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_193)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_193)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_194, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_194)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_194)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_195, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_195)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_195)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_196, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_196)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_196)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_197, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_197)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_197)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_198, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_198)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_198)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_199, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_199)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_199)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_200, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_200)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_200)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_201, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_201)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_201)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_202, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_202)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_202)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_203, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_203)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_203)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_204, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_204)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_204)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_205, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_205)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_205)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_206, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_206)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_206)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_207, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,12}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_207)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_207)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end








  defp draw_object(graph, :cell_208, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_208)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_208)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_209, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_209)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_209)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_210, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_210)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_210)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_211, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_211)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_211)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_212, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_212)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_212)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_213, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_213)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_213)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_214, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_214)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_214)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_215, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_215)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_215)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_216, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_216)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_216)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_217, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_217)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_217)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_218, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_218)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_218)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_219, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_219)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_219)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_220, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_220)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_220)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_221, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_221)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_221)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_222, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_222)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_222)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_223, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,13}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_223)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_223)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end










  defp draw_object(graph, :cell_224, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_224)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_224)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_225, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_225)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_225)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_226, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_226)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_226)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_227, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_227)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_227)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_228, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_228)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_228)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_229, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_229)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_229)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_230, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_230)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_230)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_231, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_231)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_231)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_232, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_232)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_232)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_233, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_233)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_233)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_234, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_234)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_234)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_235, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_235)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_235)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_236, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_236)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_236)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_237, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_237)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_237)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_238, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_238)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_238)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_239, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,14}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_239)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_239)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end










  defp draw_object(graph, :cell_240, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{0,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_240)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_240)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_241, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{1,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_241)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_241)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_242, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{2,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_242)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_242)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_243, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{3,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_243)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_243)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_244, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{4,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_244)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_244)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_245, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{5,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_245)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_245)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_246, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{6,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_246)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_246)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_247, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{7,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_247)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_247)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_248, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{8,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_248)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_248)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_249, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{9,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_249)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_249)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_250, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{10,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_250)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_250)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_251, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{11,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_251)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_251)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_252, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{12,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_252)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_252)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_253, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{13,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_253)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_253)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_254, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{14,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_254)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_254)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end

  defp draw_object(graph, :cell_255, %{cell: cell, coord: coord}, generation) do
    #for each cell in cells, if 1 => draw green cell at coord[i], otherwise nil
    {hx, hy} = coord
    if controller(generation)[{15,15}] == 1 do
      draw_tile(graph, hx, hy, fill: :lime, id: :cell_255)
    else
      draw_tile(graph, hx, hy, fill: :black, id: :cell_255)
    end
    #put_in(graph, [:cell0], cell: &(&1 + 1))
  end








  # Game of Life logic held withing controller()

  defp controller(index) do

      starter_culture = %{{0,0} => 0, {1,0} => 0, {2,0} => 0, {3,0} => 0, {4,0} => 0, {5,0} => 0, {6,0} => 0, {7,0} => 0,
                          {8,0} => 0, {9,0} => 0, {10,0} => 0, {11,0} => 0, {12,0} => 0, {13,0} => 0, {14,0} => 0, {15,0} => 0,

                          {0,1} => 0, {1,1} => 0, {2,1} => 0, {3,1} => 0, {4,1} => 0, {5,1} => 0, {6,1} => 0, {7,1} => 0,
                          {8,1} => 0, {9,1} => 0, {10,1} => 0, {11,1} => 0, {12,1} => 0, {13,1} => 0, {14,1} => 0, {15,1} => 0,

                          {0,2} => 0, {1,2} => 0, {2,2} => 0, {3,2} => 0, {4,2} => 0, {5,2} => 0, {6,2} => 0, {7,2} => 0,
                          {8,2} => 0, {9,2} => 0, {10,2} => 0, {11,2} => 0, {12,2} => 0, {13,2} => 0, {14,2} => 0, {15,2} => 0,

                          {0,3} => 0, {1,3} => 0, {2,3} => 0, {3,3} => 0, {4,3} => 0, {5,3} => 0, {6,3} => 0, {7,3} => 0,
                          {8,3} => 0, {9,3} => 0, {10,3} => 0, {11,3} => 0, {12,3} => 0, {13,3} => 0, {14,3} => 0, {15,3} => 0,

                          {0,4} => 0, {1,4} => 0, {2,4} => 0, {3,4} => 0, {4,4} => 0, {5,4} => 0, {6,4} => 0, {7,4} => 0,
                          {8,4} => 0, {9,4} => 0, {10,4} => 0, {11,4} => 0, {12,4} => 0, {13,4} => 0, {14,4} => 0, {15,4} => 0,

                          {0,5} => 0, {1,5} => 0, {2,5} => 0, {3,5} => 0, {4,5} => 0, {5,5} => 0, {6,5} => 0, {7,5} => 0,
                          {8,5} => 0, {9,5} => 0, {10,5} => 0, {11,5} => 0, {12,5} => 0, {13,5} => 0, {14,5} => 0, {15,5} => 0,

                          {0,6} => 0, {1,6} => 1, {2,6} => 0, {3,6} => 0, {4,6} => 0, {5,6} => 1, {6,6} => 1, {7,6} => 0,
                          {8,6} => 0, {9,6} => 1, {10,6} => 1, {11,6} => 0, {12,6} => 0, {13,6} => 1, {14,6} => 1, {15,6} => 0,

                          {0,7} => 0, {1,7} => 1, {2,7} => 0, {3,7} => 0, {4,7} => 0, {5,7} => 0, {6,7} => 0, {7,7} => 0,
                          {8,7} => 0, {9,7} => 1, {10,7} => 0, {11,7} => 0, {12,7} => 0, {13,7} => 1, {14,7} => 0, {15,7} => 0,

                          {0,8} => 0, {1,8} => 1, {2,8} => 0, {3,8} => 0, {4,8} => 0, {5,8} => 1, {6,8} => 1, {7,8} => 0,
                          {8,8} => 0, {9,8} => 1, {10,8} => 1, {11,8} => 0, {12,8} => 0, {13,8} => 1, {14,8} => 1, {15,8} => 0,

                          {0,9} => 0, {1,9} => 1, {2,9} => 0, {3,9} => 0, {4,9} => 0, {5,9} => 1, {6,9} => 1, {7,9} => 0,
                          {8,9} => 0, {9,9} => 1, {10,9} => 0, {11,9} => 0, {12,9} => 0, {13,9} => 1, {14,9} => 0, {15,9} => 0,

                          {0,10} => 0, {1,10} => 1, {2,10} => 1, {3,10} => 0, {4,10} => 0, {5,10} => 1, {6,10} => 1, {7,10} => 0,
                          {8,10} => 0, {9,10} => 1, {10,10} => 0, {11,10} => 0, {12,10} => 0, {13,10} => 1, {14,10} => 1, {15,10} => 0,

                          {0,11} => 0, {1,11} => 0, {2,11} => 0, {3,11} => 0, {4,11} => 0, {5,11} => 0, {6,11} => 0, {7,11} => 0,
                          {8,11} => 0, {9,11} => 0, {10,11} => 0, {11,11} => 0, {12,11} => 0, {13,11} => 0, {14,11} => 0, {15,11} => 0,

                          {0,12} => 0, {1,12} => 0, {2,12} => 0, {3,12} => 0, {4,12} => 0, {5,12} => 0, {6,12} => 0, {7,12} => 0,
                          {8,12} => 0, {9,12} => 0, {10,12} => 0, {11,12} => 0, {12,12} => 0, {13,12} => 0, {14,12} => 0, {15,12} => 0,

                          {0,13} => 0, {1,13} => 0, {2,13} => 0, {3,13} => 0, {4,13} => 0, {5,13} => 0, {6,13} => 0, {7,13} => 0,
                          {8,13} => 0, {9,13} => 0, {10,13} => 0, {11,13} => 0, {12,13} => 0, {13,13} => 0, {14,13} => 0, {15,13} => 0,

                          {0,14} => 0, {1,14} => 0, {2,14} => 0, {3,14} => 0, {4,14} => 0, {5,14} => 0, {6,14} => 0, {7,14} => 0,
                          {8,14} => 0, {9,14} => 0, {10,14} => 0, {11,14} => 0, {12,14} => 0, {13,14} => 0, {14,14} => 0, {15,14} => 0,

                          {0,15} => 0, {1,15} => 0, {2,15} => 0, {3,15} => 0, {4,15} => 0, {5,15} => 0, {6,15} => 0, {7,15} => 0,
                          {8,15} => 0, {9,15} => 0, {10,15} => 0, {11,15} => 0, {12,15} => 0, {13,15} => 0, {14,15} => 0, {15,15} => 0,


                        }

      if index === 0 do
        starter_culture
      else
        controller(index - 1, starter_culture)
      end

  end


  defp controller(index, previous_map) do

    board_map = previous_map

    if index === -1 do
      board_map
    else
      local_list = [count_neighbours({0,0}, board_map), count_neighbours({0,1}, board_map),  count_neighbours({0,2}, board_map), count_neighbours({0,3}, board_map),
                    count_neighbours({0,4}, board_map), count_neighbours({0,5}, board_map),  count_neighbours({0,6}, board_map), count_neighbours({0,7}, board_map),
                    count_neighbours({0,8}, board_map), count_neighbours({0,9}, board_map),  count_neighbours({0,10}, board_map), count_neighbours({0,11}, board_map),
                    count_neighbours({0,12}, board_map), count_neighbours({0,13}, board_map),  count_neighbours({0,14}, board_map), count_neighbours({0,15}, board_map),

                    count_neighbours({1,0}, board_map), count_neighbours({1,1}, board_map),  count_neighbours({1,2}, board_map), count_neighbours({1,3}, board_map),
                    count_neighbours({1,4}, board_map), count_neighbours({1,5}, board_map),  count_neighbours({1,6}, board_map), count_neighbours({1,7}, board_map),
                    count_neighbours({1,8}, board_map), count_neighbours({1,9}, board_map),  count_neighbours({1,10}, board_map), count_neighbours({1,11}, board_map),
                    count_neighbours({1,12}, board_map), count_neighbours({1,13}, board_map),  count_neighbours({1,14}, board_map), count_neighbours({1,15}, board_map),

                    count_neighbours({2,0}, board_map), count_neighbours({2,1}, board_map),  count_neighbours({2,2}, board_map), count_neighbours({2,3}, board_map),
                    count_neighbours({2,4}, board_map), count_neighbours({2,5}, board_map),  count_neighbours({2,6}, board_map), count_neighbours({2,7}, board_map),
                    count_neighbours({2,8}, board_map), count_neighbours({2,9}, board_map),  count_neighbours({2,10}, board_map), count_neighbours({2,11}, board_map),
                    count_neighbours({2,12}, board_map), count_neighbours({2,13}, board_map),  count_neighbours({2,14}, board_map), count_neighbours({2,15}, board_map),

                    count_neighbours({3,0}, board_map), count_neighbours({3,1}, board_map),  count_neighbours({3,2}, board_map), count_neighbours({3,3}, board_map),
                    count_neighbours({3,4}, board_map), count_neighbours({3,5}, board_map),  count_neighbours({3,6}, board_map), count_neighbours({3,7}, board_map),
                    count_neighbours({3,8}, board_map), count_neighbours({3,9}, board_map),  count_neighbours({3,10}, board_map), count_neighbours({3,11}, board_map),
                    count_neighbours({3,12}, board_map), count_neighbours({3,13}, board_map),  count_neighbours({3,14}, board_map), count_neighbours({3,15}, board_map),

                    count_neighbours({4,0}, board_map), count_neighbours({4,1}, board_map),  count_neighbours({4,2}, board_map), count_neighbours({4,3}, board_map),
                    count_neighbours({4,4}, board_map), count_neighbours({4,5}, board_map),  count_neighbours({4,6}, board_map), count_neighbours({4,7}, board_map),
                    count_neighbours({4,8}, board_map), count_neighbours({4,9}, board_map),  count_neighbours({4,10}, board_map), count_neighbours({4,11}, board_map),
                    count_neighbours({4,12}, board_map), count_neighbours({4,13}, board_map),  count_neighbours({4,14}, board_map), count_neighbours({4,15}, board_map),

                    count_neighbours({5,0}, board_map), count_neighbours({5,1}, board_map),  count_neighbours({5,2}, board_map), count_neighbours({5,3}, board_map),
                    count_neighbours({5,4}, board_map), count_neighbours({5,5}, board_map),  count_neighbours({5,6}, board_map), count_neighbours({5,7}, board_map),
                    count_neighbours({5,8}, board_map), count_neighbours({5,9}, board_map),  count_neighbours({5,10}, board_map), count_neighbours({5,11}, board_map),
                    count_neighbours({5,12}, board_map), count_neighbours({5,13}, board_map),  count_neighbours({5,14}, board_map), count_neighbours({5,15}, board_map),

                    count_neighbours({6,0}, board_map), count_neighbours({6,1}, board_map),  count_neighbours({6,2}, board_map), count_neighbours({6,3}, board_map),
                    count_neighbours({6,4}, board_map), count_neighbours({6,5}, board_map),  count_neighbours({6,6}, board_map), count_neighbours({6,7}, board_map),
                    count_neighbours({6,8}, board_map), count_neighbours({6,9}, board_map),  count_neighbours({6,10}, board_map), count_neighbours({6,11}, board_map),
                    count_neighbours({6,12}, board_map), count_neighbours({6,13}, board_map),  count_neighbours({6,14}, board_map), count_neighbours({6,15}, board_map),

                    count_neighbours({7,0}, board_map), count_neighbours({7,1}, board_map),  count_neighbours({7,2}, board_map), count_neighbours({7,3}, board_map),
                    count_neighbours({7,4}, board_map), count_neighbours({7,5}, board_map),  count_neighbours({7,6}, board_map), count_neighbours({7,7}, board_map),
                    count_neighbours({7,8}, board_map), count_neighbours({7,9}, board_map),  count_neighbours({7,10}, board_map), count_neighbours({7,11}, board_map),
                    count_neighbours({7,12}, board_map), count_neighbours({7,13}, board_map),  count_neighbours({7,14}, board_map), count_neighbours({7,15}, board_map),

                    count_neighbours({8,0}, board_map), count_neighbours({8,1}, board_map),  count_neighbours({8,2}, board_map), count_neighbours({8,3}, board_map),
                    count_neighbours({8,4}, board_map), count_neighbours({8,5}, board_map),  count_neighbours({8,6}, board_map), count_neighbours({8,7}, board_map),
                    count_neighbours({8,8}, board_map), count_neighbours({8,9}, board_map),  count_neighbours({8,10}, board_map), count_neighbours({8,11}, board_map),
                    count_neighbours({8,12}, board_map), count_neighbours({8,13}, board_map),  count_neighbours({8,14}, board_map), count_neighbours({8,15}, board_map),

                    count_neighbours({9,0}, board_map), count_neighbours({9,1}, board_map),  count_neighbours({9,2}, board_map), count_neighbours({9,3}, board_map),
                    count_neighbours({9,4}, board_map), count_neighbours({9,5}, board_map),  count_neighbours({9,6}, board_map), count_neighbours({9,7}, board_map),
                    count_neighbours({9,8}, board_map), count_neighbours({9,9}, board_map),  count_neighbours({9,10}, board_map), count_neighbours({9,11}, board_map),
                    count_neighbours({9,12}, board_map), count_neighbours({9,13}, board_map),  count_neighbours({9,14}, board_map), count_neighbours({9,15}, board_map),

                    count_neighbours({10,0}, board_map), count_neighbours({10,1}, board_map),  count_neighbours({10,2}, board_map), count_neighbours({10,3}, board_map),
                    count_neighbours({10,4}, board_map), count_neighbours({10,5}, board_map),  count_neighbours({10,6}, board_map), count_neighbours({10,7}, board_map),
                    count_neighbours({10,8}, board_map), count_neighbours({10,9}, board_map),  count_neighbours({10,10}, board_map), count_neighbours({10,11}, board_map),
                    count_neighbours({10,12}, board_map), count_neighbours({10,13}, board_map),  count_neighbours({10,14}, board_map), count_neighbours({10,15}, board_map),

                    count_neighbours({11,0}, board_map), count_neighbours({11,1}, board_map),  count_neighbours({11,2}, board_map), count_neighbours({11,3}, board_map),
                    count_neighbours({11,4}, board_map), count_neighbours({11,5}, board_map),  count_neighbours({11,6}, board_map), count_neighbours({11,7}, board_map),
                    count_neighbours({11,8}, board_map), count_neighbours({11,9}, board_map),  count_neighbours({11,10}, board_map), count_neighbours({11,11}, board_map),
                    count_neighbours({11,12}, board_map), count_neighbours({11,13}, board_map),  count_neighbours({11,14}, board_map), count_neighbours({11,15}, board_map),

                    count_neighbours({12,0}, board_map), count_neighbours({12,1}, board_map),  count_neighbours({12,2}, board_map), count_neighbours({12,3}, board_map),
                    count_neighbours({12,4}, board_map), count_neighbours({12,5}, board_map),  count_neighbours({12,6}, board_map), count_neighbours({12,7}, board_map),
                    count_neighbours({12,8}, board_map), count_neighbours({12,9}, board_map),  count_neighbours({12,10}, board_map), count_neighbours({12,11}, board_map),
                    count_neighbours({12,12}, board_map), count_neighbours({12,13}, board_map),  count_neighbours({12,14}, board_map), count_neighbours({12,15}, board_map),

                    count_neighbours({13,0}, board_map), count_neighbours({13,1}, board_map),  count_neighbours({13,2}, board_map), count_neighbours({13,3}, board_map),
                    count_neighbours({13,4}, board_map), count_neighbours({13,5}, board_map),  count_neighbours({13,6}, board_map), count_neighbours({13,7}, board_map),
                    count_neighbours({13,8}, board_map), count_neighbours({13,9}, board_map),  count_neighbours({13,10}, board_map), count_neighbours({13,11}, board_map),
                    count_neighbours({13,12}, board_map), count_neighbours({13,13}, board_map),  count_neighbours({13,14}, board_map), count_neighbours({13,15}, board_map),

                    count_neighbours({14,0}, board_map), count_neighbours({14,1}, board_map),  count_neighbours({14,2}, board_map), count_neighbours({14,3}, board_map),
                    count_neighbours({14,4}, board_map), count_neighbours({14,5}, board_map),  count_neighbours({14,6}, board_map), count_neighbours({14,7}, board_map),
                    count_neighbours({14,8}, board_map), count_neighbours({14,9}, board_map),  count_neighbours({14,10}, board_map), count_neighbours({14,11}, board_map),
                    count_neighbours({14,12}, board_map), count_neighbours({14,13}, board_map),  count_neighbours({14,14}, board_map), count_neighbours({14,15}, board_map),

                    count_neighbours({15,0}, board_map), count_neighbours({15,1}, board_map),  count_neighbours({15,2}, board_map), count_neighbours({15,3}, board_map),
                    count_neighbours({15,4}, board_map), count_neighbours({15,5}, board_map),  count_neighbours({15,6}, board_map), count_neighbours({15,7}, board_map),
                    count_neighbours({15,8}, board_map), count_neighbours({15,9}, board_map),  count_neighbours({15,10}, board_map), count_neighbours({15,11}, board_map),
                    count_neighbours({15,12}, board_map), count_neighbours({15,13}, board_map),  count_neighbours({15,14}, board_map), count_neighbours({15,15}, board_map)
                  ]



      permutation_list = [is_alive?(board_map, 0, local_list), is_alive?(board_map, 1, local_list),
                          is_alive?(board_map, 2, local_list), is_alive?(board_map, 3, local_list),
                          is_alive?(board_map, 4, local_list), is_alive?(board_map, 5, local_list),
                          is_alive?(board_map, 6, local_list), is_alive?(board_map, 7, local_list),
                          is_alive?(board_map, 8, local_list), is_alive?(board_map, 9, local_list),
                          is_alive?(board_map, 10, local_list), is_alive?(board_map, 11, local_list),
                          is_alive?(board_map, 12, local_list), is_alive?(board_map, 13, local_list),
                          is_alive?(board_map, 14, local_list), is_alive?(board_map, 15, local_list),

                          is_alive?(board_map, 16, local_list), is_alive?(board_map, 17, local_list),
                          is_alive?(board_map, 18, local_list), is_alive?(board_map, 19, local_list),
                          is_alive?(board_map, 20, local_list), is_alive?(board_map, 21, local_list),
                          is_alive?(board_map, 22, local_list), is_alive?(board_map, 23, local_list),
                          is_alive?(board_map, 24, local_list), is_alive?(board_map, 25, local_list),
                          is_alive?(board_map, 26, local_list), is_alive?(board_map, 27, local_list),
                          is_alive?(board_map, 28, local_list), is_alive?(board_map, 29, local_list),
                          is_alive?(board_map, 30, local_list), is_alive?(board_map, 31, local_list),

                          is_alive?(board_map, 32, local_list), is_alive?(board_map, 33, local_list),
                          is_alive?(board_map, 34, local_list), is_alive?(board_map, 35, local_list),
                          is_alive?(board_map, 36, local_list), is_alive?(board_map, 37, local_list),
                          is_alive?(board_map, 38, local_list), is_alive?(board_map, 39, local_list),
                          is_alive?(board_map, 40, local_list), is_alive?(board_map, 41, local_list),
                          is_alive?(board_map, 42, local_list), is_alive?(board_map, 43, local_list),
                          is_alive?(board_map, 44, local_list), is_alive?(board_map, 45, local_list),
                          is_alive?(board_map, 46, local_list), is_alive?(board_map, 47, local_list),

                          is_alive?(board_map, 48, local_list), is_alive?(board_map, 49, local_list),
                          is_alive?(board_map, 50, local_list), is_alive?(board_map, 51, local_list),
                          is_alive?(board_map, 52, local_list), is_alive?(board_map, 53, local_list),
                          is_alive?(board_map, 54, local_list), is_alive?(board_map, 55, local_list),
                          is_alive?(board_map, 56, local_list), is_alive?(board_map, 57, local_list),
                          is_alive?(board_map, 58, local_list), is_alive?(board_map, 59, local_list),
                          is_alive?(board_map, 60, local_list), is_alive?(board_map, 61, local_list),
                          is_alive?(board_map, 62, local_list), is_alive?(board_map, 63, local_list),

                          is_alive?(board_map, 64, local_list), is_alive?(board_map, 65, local_list),
                          is_alive?(board_map, 66, local_list), is_alive?(board_map, 67, local_list),
                          is_alive?(board_map, 68, local_list), is_alive?(board_map, 69, local_list),
                          is_alive?(board_map, 70, local_list), is_alive?(board_map, 71, local_list),
                          is_alive?(board_map, 72, local_list), is_alive?(board_map, 73, local_list),
                          is_alive?(board_map, 74, local_list), is_alive?(board_map, 75, local_list),
                          is_alive?(board_map, 76, local_list), is_alive?(board_map, 77, local_list),
                          is_alive?(board_map, 78, local_list), is_alive?(board_map, 79, local_list),

                          is_alive?(board_map, 80, local_list), is_alive?(board_map, 81, local_list),
                          is_alive?(board_map, 82, local_list), is_alive?(board_map, 83, local_list),
                          is_alive?(board_map, 84, local_list), is_alive?(board_map, 85, local_list),
                          is_alive?(board_map, 86, local_list), is_alive?(board_map, 87, local_list),
                          is_alive?(board_map, 88, local_list), is_alive?(board_map, 89, local_list),
                          is_alive?(board_map, 90, local_list), is_alive?(board_map, 91, local_list),
                          is_alive?(board_map, 92, local_list), is_alive?(board_map, 93, local_list),
                          is_alive?(board_map, 94, local_list), is_alive?(board_map, 95, local_list),

                          is_alive?(board_map, 96, local_list), is_alive?(board_map, 97, local_list),
                          is_alive?(board_map, 98, local_list), is_alive?(board_map, 99, local_list),
                          is_alive?(board_map, 100, local_list), is_alive?(board_map, 101, local_list),
                          is_alive?(board_map, 102, local_list), is_alive?(board_map, 103, local_list),
                          is_alive?(board_map, 104, local_list), is_alive?(board_map, 105, local_list),
                          is_alive?(board_map, 106, local_list), is_alive?(board_map, 107, local_list),
                          is_alive?(board_map, 108, local_list), is_alive?(board_map, 109, local_list),
                          is_alive?(board_map, 110, local_list), is_alive?(board_map, 111, local_list),

                          is_alive?(board_map, 112, local_list), is_alive?(board_map, 113, local_list),
                          is_alive?(board_map, 114, local_list), is_alive?(board_map, 115, local_list),
                          is_alive?(board_map, 116, local_list), is_alive?(board_map, 117, local_list),
                          is_alive?(board_map, 118, local_list), is_alive?(board_map, 119, local_list),
                          is_alive?(board_map, 120, local_list), is_alive?(board_map, 121, local_list),
                          is_alive?(board_map, 122, local_list), is_alive?(board_map, 123, local_list),
                          is_alive?(board_map, 124, local_list), is_alive?(board_map, 125, local_list),
                          is_alive?(board_map, 126, local_list), is_alive?(board_map, 127, local_list),

                          is_alive?(board_map, 128, local_list), is_alive?(board_map, 129, local_list),
                          is_alive?(board_map, 130, local_list), is_alive?(board_map, 131, local_list),
                          is_alive?(board_map, 132, local_list), is_alive?(board_map, 133, local_list),
                          is_alive?(board_map, 134, local_list), is_alive?(board_map, 135, local_list),
                          is_alive?(board_map, 136, local_list), is_alive?(board_map, 137, local_list),
                          is_alive?(board_map, 138, local_list), is_alive?(board_map, 139, local_list),
                          is_alive?(board_map, 140, local_list), is_alive?(board_map, 141, local_list),
                          is_alive?(board_map, 142, local_list), is_alive?(board_map, 143, local_list),

                          is_alive?(board_map, 144, local_list), is_alive?(board_map, 145, local_list),
                          is_alive?(board_map, 146, local_list), is_alive?(board_map, 147, local_list),
                          is_alive?(board_map, 148, local_list), is_alive?(board_map, 149, local_list),
                          is_alive?(board_map, 150, local_list), is_alive?(board_map, 151, local_list),
                          is_alive?(board_map, 152, local_list), is_alive?(board_map, 153, local_list),
                          is_alive?(board_map, 154, local_list), is_alive?(board_map, 155, local_list),
                          is_alive?(board_map, 156, local_list), is_alive?(board_map, 157, local_list),
                          is_alive?(board_map, 158, local_list), is_alive?(board_map, 159, local_list),

                          is_alive?(board_map, 160, local_list), is_alive?(board_map, 161, local_list),
                          is_alive?(board_map, 162, local_list), is_alive?(board_map, 163, local_list),
                          is_alive?(board_map, 164, local_list), is_alive?(board_map, 165, local_list),
                          is_alive?(board_map, 166, local_list), is_alive?(board_map, 167, local_list),
                          is_alive?(board_map, 168, local_list), is_alive?(board_map, 169, local_list),
                          is_alive?(board_map, 170, local_list), is_alive?(board_map, 171, local_list),
                          is_alive?(board_map, 172, local_list), is_alive?(board_map, 173, local_list),
                          is_alive?(board_map, 174, local_list), is_alive?(board_map, 175, local_list),

                          is_alive?(board_map, 176, local_list), is_alive?(board_map, 177, local_list),
                          is_alive?(board_map, 178, local_list), is_alive?(board_map, 179, local_list),
                          is_alive?(board_map, 180, local_list), is_alive?(board_map, 181, local_list),
                          is_alive?(board_map, 182, local_list), is_alive?(board_map, 183, local_list),
                          is_alive?(board_map, 184, local_list), is_alive?(board_map, 185, local_list),
                          is_alive?(board_map, 186, local_list), is_alive?(board_map, 187, local_list),
                          is_alive?(board_map, 188, local_list), is_alive?(board_map, 189, local_list),
                          is_alive?(board_map, 190, local_list), is_alive?(board_map, 191, local_list),

                          is_alive?(board_map, 192, local_list), is_alive?(board_map, 193, local_list),
                          is_alive?(board_map, 194, local_list), is_alive?(board_map, 195, local_list),
                          is_alive?(board_map, 196, local_list), is_alive?(board_map, 197, local_list),
                          is_alive?(board_map, 198, local_list), is_alive?(board_map, 199, local_list),
                          is_alive?(board_map, 200, local_list), is_alive?(board_map, 201, local_list),
                          is_alive?(board_map, 202, local_list), is_alive?(board_map, 203, local_list),
                          is_alive?(board_map, 204, local_list), is_alive?(board_map, 205, local_list),
                          is_alive?(board_map, 206, local_list), is_alive?(board_map, 207, local_list),

                          is_alive?(board_map, 208, local_list), is_alive?(board_map, 209, local_list),
                          is_alive?(board_map, 210, local_list), is_alive?(board_map, 211, local_list),
                          is_alive?(board_map, 212, local_list), is_alive?(board_map, 213, local_list),
                          is_alive?(board_map, 214, local_list), is_alive?(board_map, 215, local_list),
                          is_alive?(board_map, 216, local_list), is_alive?(board_map, 217, local_list),
                          is_alive?(board_map, 218, local_list), is_alive?(board_map, 219, local_list),
                          is_alive?(board_map, 220, local_list), is_alive?(board_map, 221, local_list),
                          is_alive?(board_map, 222, local_list), is_alive?(board_map, 223, local_list),

                          is_alive?(board_map, 224, local_list), is_alive?(board_map, 225, local_list),
                          is_alive?(board_map, 226, local_list), is_alive?(board_map, 227, local_list),
                          is_alive?(board_map, 228, local_list), is_alive?(board_map, 229, local_list),
                          is_alive?(board_map, 230, local_list), is_alive?(board_map, 231, local_list),
                          is_alive?(board_map, 232, local_list), is_alive?(board_map, 233, local_list),
                          is_alive?(board_map, 234, local_list), is_alive?(board_map, 235, local_list),
                          is_alive?(board_map, 236, local_list), is_alive?(board_map, 237, local_list),
                          is_alive?(board_map, 238, local_list), is_alive?(board_map, 239, local_list),

                          is_alive?(board_map, 240, local_list), is_alive?(board_map, 241, local_list),
                          is_alive?(board_map, 242, local_list), is_alive?(board_map, 243, local_list),
                          is_alive?(board_map, 244, local_list), is_alive?(board_map, 245, local_list),
                          is_alive?(board_map, 246, local_list), is_alive?(board_map, 247, local_list),
                          is_alive?(board_map, 248, local_list), is_alive?(board_map, 249, local_list),
                          is_alive?(board_map, 250, local_list), is_alive?(board_map, 251, local_list),
                          is_alive?(board_map, 252, local_list), is_alive?(board_map, 253, local_list),
                          is_alive?(board_map, 254, local_list), is_alive?(board_map, 255, local_list)

                        ]



      new_board_map = %{{0,0} => Enum.at(permutation_list, 0), {1,0} => Enum.at(permutation_list, 1),
                        {2,0} => Enum.at(permutation_list, 2), {3,0} => Enum.at(permutation_list, 3),
                        {4,0} => Enum.at(permutation_list, 4), {5,0} => Enum.at(permutation_list, 5),
                        {6,0} => Enum.at(permutation_list, 6), {7,0} => Enum.at(permutation_list, 7),
                        {8,0} => Enum.at(permutation_list, 8), {9,0} => Enum.at(permutation_list, 9),
                        {10,0} => Enum.at(permutation_list, 10), {11,0} => Enum.at(permutation_list, 11),
                        {12,0} => Enum.at(permutation_list, 12), {13,0} => Enum.at(permutation_list, 13),
                        {14,0} => Enum.at(permutation_list, 14), {15,0} => Enum.at(permutation_list, 15),

                        {0,1} => Enum.at(permutation_list, 16), {1,1} => Enum.at(permutation_list, 17),
                        {2,1} => Enum.at(permutation_list, 18), {3,1} => Enum.at(permutation_list, 19),
                        {4,1} => Enum.at(permutation_list, 20), {5,1} => Enum.at(permutation_list, 21),
                        {6,1} => Enum.at(permutation_list, 22), {7,1} => Enum.at(permutation_list, 23),
                        {8,1} => Enum.at(permutation_list, 24), {9,1} => Enum.at(permutation_list, 25),
                        {10,1} => Enum.at(permutation_list, 26), {11,1} => Enum.at(permutation_list, 27),
                        {12,1} => Enum.at(permutation_list, 28), {13,1} => Enum.at(permutation_list, 29),
                        {14,1} => Enum.at(permutation_list, 30), {15,1} => Enum.at(permutation_list, 31),

                        {0,2} => Enum.at(permutation_list, 32), {1,2} => Enum.at(permutation_list, 33),
                        {2,2} => Enum.at(permutation_list, 34), {3,2} => Enum.at(permutation_list, 35),
                        {4,2} => Enum.at(permutation_list, 36), {5,2} => Enum.at(permutation_list, 37),
                        {6,2} => Enum.at(permutation_list, 38), {7,2} => Enum.at(permutation_list, 39),
                        {8,2} => Enum.at(permutation_list, 40), {9,2} => Enum.at(permutation_list, 41),
                        {10,2} => Enum.at(permutation_list, 42), {11,2} => Enum.at(permutation_list, 43),
                        {12,2} => Enum.at(permutation_list, 44), {13,2} => Enum.at(permutation_list, 45),
                        {14,2} => Enum.at(permutation_list, 46), {15,2} => Enum.at(permutation_list, 47),

                        {0,3} => Enum.at(permutation_list, 48), {1,3} => Enum.at(permutation_list, 49),
                        {2,3} => Enum.at(permutation_list, 50), {3,3} => Enum.at(permutation_list, 51),
                        {4,3} => Enum.at(permutation_list, 52), {5,3} => Enum.at(permutation_list, 53),
                        {6,3} => Enum.at(permutation_list, 54), {7,3} => Enum.at(permutation_list, 55),
                        {8,3} => Enum.at(permutation_list, 56), {9,3} => Enum.at(permutation_list, 57),
                        {10,3} => Enum.at(permutation_list, 58), {11,3} => Enum.at(permutation_list, 59),
                        {12,3} => Enum.at(permutation_list, 60), {13,3} => Enum.at(permutation_list, 61),
                        {14,3} => Enum.at(permutation_list, 62), {15,3} => Enum.at(permutation_list, 63),

                        {0,4} => Enum.at(permutation_list, 64), {1,4} => Enum.at(permutation_list, 65),
                        {2,4} => Enum.at(permutation_list, 66), {3,4} => Enum.at(permutation_list, 67),
                        {4,4} => Enum.at(permutation_list, 68), {5,4} => Enum.at(permutation_list, 69),
                        {6,4} => Enum.at(permutation_list, 70), {7,4} => Enum.at(permutation_list, 71),
                        {8,4} => Enum.at(permutation_list, 72), {9,4} => Enum.at(permutation_list, 73),
                        {10,4} => Enum.at(permutation_list, 74), {11,4} => Enum.at(permutation_list, 75),
                        {12,4} => Enum.at(permutation_list, 76), {13,4} => Enum.at(permutation_list, 77),
                        {14,4} => Enum.at(permutation_list, 78), {15,4} => Enum.at(permutation_list, 79),

                        {0,5} => Enum.at(permutation_list, 80), {1,5} => Enum.at(permutation_list, 81),
                        {2,5} => Enum.at(permutation_list, 82), {3,5} => Enum.at(permutation_list, 83),
                        {4,5} => Enum.at(permutation_list, 84), {5,5} => Enum.at(permutation_list, 85),
                        {6,5} => Enum.at(permutation_list, 86), {7,5} => Enum.at(permutation_list, 87),
                        {8,5} => Enum.at(permutation_list, 88), {9,5} => Enum.at(permutation_list, 89),
                        {10,5} => Enum.at(permutation_list, 90), {11,5} => Enum.at(permutation_list, 91),
                        {12,5} => Enum.at(permutation_list, 92), {13,5} => Enum.at(permutation_list, 93),
                        {14,5} => Enum.at(permutation_list, 94), {15,5} => Enum.at(permutation_list, 95),

                        {0,6} => Enum.at(permutation_list, 96), {1,6} => Enum.at(permutation_list, 97),
                        {2,6} => Enum.at(permutation_list, 98), {3,6} => Enum.at(permutation_list, 99),
                        {4,6} => Enum.at(permutation_list, 100), {5,6} => Enum.at(permutation_list, 101),
                        {6,6} => Enum.at(permutation_list, 102), {7,6} => Enum.at(permutation_list, 103),
                        {8,6} => Enum.at(permutation_list, 104), {9,6} => Enum.at(permutation_list, 105),
                        {10,6} => Enum.at(permutation_list, 106), {11,6} => Enum.at(permutation_list, 107),
                        {12,6} => Enum.at(permutation_list, 108), {13,6} => Enum.at(permutation_list, 109),
                        {14,6} => Enum.at(permutation_list, 110), {15,6} => Enum.at(permutation_list, 111),

                        {0,7} => Enum.at(permutation_list, 112), {1,7} => Enum.at(permutation_list, 113),
                        {2,7} => Enum.at(permutation_list, 114), {3,7} => Enum.at(permutation_list, 115),
                        {4,7} => Enum.at(permutation_list, 116), {5,7} => Enum.at(permutation_list, 117),
                        {6,7} => Enum.at(permutation_list, 118), {7,7} => Enum.at(permutation_list, 119),
                        {8,7} => Enum.at(permutation_list, 120), {9,7} => Enum.at(permutation_list, 121),
                        {10,7} => Enum.at(permutation_list, 122), {11,7} => Enum.at(permutation_list, 123),
                        {12,7} => Enum.at(permutation_list, 124), {13,7} => Enum.at(permutation_list, 125),
                        {14,7} => Enum.at(permutation_list, 126), {15,7} => Enum.at(permutation_list, 127),

                        {0,8} => Enum.at(permutation_list, 128), {1,8} => Enum.at(permutation_list, 129),
                        {2,8} => Enum.at(permutation_list, 130), {3,8} => Enum.at(permutation_list, 131),
                        {4,8} => Enum.at(permutation_list, 132), {5,8} => Enum.at(permutation_list, 133),
                        {6,8} => Enum.at(permutation_list, 134), {7,8} => Enum.at(permutation_list, 135),
                        {8,8} => Enum.at(permutation_list, 136), {9,8} => Enum.at(permutation_list, 137),
                        {10,8} => Enum.at(permutation_list, 138), {11,8} => Enum.at(permutation_list, 139),
                        {12,8} => Enum.at(permutation_list, 140), {13,8} => Enum.at(permutation_list, 141),
                        {14,8} => Enum.at(permutation_list, 142), {15,8} => Enum.at(permutation_list, 143),

                        {0,9} => Enum.at(permutation_list, 144), {1,9} => Enum.at(permutation_list, 145),
                        {2,9} => Enum.at(permutation_list, 146), {3,9} => Enum.at(permutation_list, 147),
                        {4,9} => Enum.at(permutation_list, 148), {5,9} => Enum.at(permutation_list, 149),
                        {6,9} => Enum.at(permutation_list, 150), {7,9} => Enum.at(permutation_list, 151),
                        {8,9} => Enum.at(permutation_list, 152), {9,9} => Enum.at(permutation_list, 153),
                        {10,9} => Enum.at(permutation_list, 154), {11,9} => Enum.at(permutation_list, 155),
                        {12,9} => Enum.at(permutation_list, 156), {13,9} => Enum.at(permutation_list, 157),
                        {14,9} => Enum.at(permutation_list, 158), {15,9} => Enum.at(permutation_list, 159),

                        {0,10} => Enum.at(permutation_list, 160), {1,10} => Enum.at(permutation_list, 161),
                        {2,10} => Enum.at(permutation_list, 162), {3,10} => Enum.at(permutation_list, 163),
                        {4,10} => Enum.at(permutation_list, 164), {5,10} => Enum.at(permutation_list, 165),
                        {6,10} => Enum.at(permutation_list, 166), {7,10} => Enum.at(permutation_list, 167),
                        {8,10} => Enum.at(permutation_list, 168), {9,10} => Enum.at(permutation_list, 169),
                        {10,10} => Enum.at(permutation_list, 170), {11,10} => Enum.at(permutation_list, 171),
                        {12,10} => Enum.at(permutation_list, 172), {13,10} => Enum.at(permutation_list, 173),
                        {14,10} => Enum.at(permutation_list, 174), {15,10} => Enum.at(permutation_list, 175),

                        {0,11} => Enum.at(permutation_list, 176), {1,11} => Enum.at(permutation_list, 177),
                        {2,11} => Enum.at(permutation_list, 178), {3,11} => Enum.at(permutation_list, 179),
                        {4,11} => Enum.at(permutation_list, 180), {5,11} => Enum.at(permutation_list, 181),
                        {6,11} => Enum.at(permutation_list, 182), {7,11} => Enum.at(permutation_list, 183),
                        {8,11} => Enum.at(permutation_list, 184), {9,11} => Enum.at(permutation_list, 185),
                        {10,11} => Enum.at(permutation_list, 186), {11,11} => Enum.at(permutation_list, 187),
                        {12,11} => Enum.at(permutation_list, 188), {13,11} => Enum.at(permutation_list, 189),
                        {14,11} => Enum.at(permutation_list, 190), {15,11} => Enum.at(permutation_list, 191),

                        {0,12} => Enum.at(permutation_list, 192), {1,12} => Enum.at(permutation_list, 193),
                        {2,12} => Enum.at(permutation_list, 194), {3,12} => Enum.at(permutation_list, 195),
                        {4,12} => Enum.at(permutation_list, 196), {5,12} => Enum.at(permutation_list, 197),
                        {6,12} => Enum.at(permutation_list, 198), {7,12} => Enum.at(permutation_list, 199),
                        {8,12} => Enum.at(permutation_list, 200), {9,12} => Enum.at(permutation_list, 201),
                        {10,12} => Enum.at(permutation_list, 202), {11,12} => Enum.at(permutation_list, 203),
                        {12,12} => Enum.at(permutation_list, 204), {13,12} => Enum.at(permutation_list, 205),
                        {14,12} => Enum.at(permutation_list, 206), {15,12} => Enum.at(permutation_list, 207),

                        {0,13} => Enum.at(permutation_list, 208), {1,13} => Enum.at(permutation_list, 209),
                        {2,13} => Enum.at(permutation_list, 210), {3,13} => Enum.at(permutation_list, 211),
                        {4,13} => Enum.at(permutation_list, 212), {5,13} => Enum.at(permutation_list, 213),
                        {6,13} => Enum.at(permutation_list, 214), {7,13} => Enum.at(permutation_list, 215),
                        {8,13} => Enum.at(permutation_list, 216), {9,13} => Enum.at(permutation_list, 217),
                        {10,13} => Enum.at(permutation_list, 218), {11,13} => Enum.at(permutation_list, 219),
                        {12,13} => Enum.at(permutation_list, 220), {13,13} => Enum.at(permutation_list, 221),
                        {14,13} => Enum.at(permutation_list, 222), {15,13} => Enum.at(permutation_list, 223),

                        {0,14} => Enum.at(permutation_list, 224), {1,14} => Enum.at(permutation_list, 225),
                        {2,14} => Enum.at(permutation_list, 226), {3,14} => Enum.at(permutation_list, 227),
                        {4,14} => Enum.at(permutation_list, 228), {5,14} => Enum.at(permutation_list, 229),
                        {6,14} => Enum.at(permutation_list, 230), {7,14} => Enum.at(permutation_list, 231),
                        {8,14} => Enum.at(permutation_list, 232), {9,14} => Enum.at(permutation_list, 233),
                        {10,14} => Enum.at(permutation_list, 234), {11,14} => Enum.at(permutation_list, 235),
                        {12,14} => Enum.at(permutation_list, 236), {13,14} => Enum.at(permutation_list, 237),
                        {14,14} => Enum.at(permutation_list, 238), {15,14} => Enum.at(permutation_list, 239),

                        {0,15} => Enum.at(permutation_list, 240), {1,15} => Enum.at(permutation_list, 241),
                        {2,15} => Enum.at(permutation_list, 242), {3,15} => Enum.at(permutation_list, 243),
                        {4,15} => Enum.at(permutation_list, 244), {5,15} => Enum.at(permutation_list, 245),
                        {6,15} => Enum.at(permutation_list, 246), {7,15} => Enum.at(permutation_list, 247),
                        {8,15} => Enum.at(permutation_list, 248), {9,15} => Enum.at(permutation_list, 249),
                        {10,15} => Enum.at(permutation_list, 250), {11,15} => Enum.at(permutation_list, 251),
                        {12,15} => Enum.at(permutation_list, 252), {13,15} => Enum.at(permutation_list, 253),
                        {14,15} => Enum.at(permutation_list, 254), {15,15} => Enum.at(permutation_list, 255)

                      }

      controller(index - 1, new_board_map)
    end

  end


  defp count_neighbours({false_x, false_y}, board) do
    y = false_x
    x = false_y
    count_list = [board[{x,y-1}],
                  board[{x+1, y-1}],
                  board[{x+1, y}],
                  board[{x+1, y+1}],
                  board[{x,y+1}],
                  board[{x-1, y+1}],
                  board[{x-1, y}],
                  board[{x-1, y-1}]]
    count_list
    |> Enum.reject( fn x -> x == nil end )
    |> Enum.sum()

  end



  defp is_alive?(map, index, local_sums) do
    case Enum.at(map, index) do
      {_,1} ->
        if Enum.at(local_sums, index) == 2 or Enum.at(local_sums, index) == 3 do
          1
        else
          0
        end
      {_,0} ->
        if Enum.at(local_sums, index) == 3 do
          1
        else
          0
        end
    end
  end



end
