package uqac.aop.chess;

import uqac.aop.chess.agent.AiPlayer;
import uqac.aop.chess.agent.HumanPlayer;
import uqac.aop.chess.agent.Move;
import uqac.aop.chess.agent.Player;

public class Chess {

	protected Board board;

	public Chess() {

		board = new Board();
		board.setupChessBoard();

	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}
	
	private void play() {
		Player hp = new HumanPlayer(Player.BLACK, board);
		Player ap = new AiPlayer(Player.WHITE, board);

		while (true){
			board.print();
			hp.makeMove();
			board.print();
			ap.makeMove();				
		}
	}
	
	public static void main(String[] args) {
		new Chess().play();
	}
}
