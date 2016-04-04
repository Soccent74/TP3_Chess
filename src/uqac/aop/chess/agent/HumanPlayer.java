package uqac.aop.chess.agent;

import uqac.aop.chess.Board;

public class HumanPlayer extends Player {

	public HumanPlayer(int arg, Board board) {
		setColor(arg);
		this.playGround = board;
	}

	@Override
	public boolean makeMove(Move mv, Board playground) {
		// TODO Auto-generated method stub
		if(mv.getLegal()){
			if(!playGround.getGrid()[mv.xI][mv.yI].isOccupied()){
				mv.setLegal(false);
				return false;
			}
			if(playGround.getGrid()[mv.xI][mv.yI].getPiece().getPlayer() == this.getColor()){
				mv.setLegal(false);
				return false;
			}
			if(!playGround.getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv)){
				mv.setLegal(false);
				return false;
			}
			playGround.movePiece(mv);
				return true;
		}
		else
			return false;
			
	}

	@Override
	public Move makeMove() {
		Move mv;
		char initialX = '\0';
		char initialY = '\0';
		char finalX = '\0';
		char finalY = '\0';
		do{				
			System.out.print ("Votre coup? <a2a4> ");				
			initialX = Lire();
			initialY = Lire();
			finalX = Lire();
			finalY = Lire();
			ViderBuffer();

			mv = new Move(initialX-'a', initialY-'1', finalX - 'a', 	finalY-'1');
		}
		while(!makeMove(mv, this.playGround));
		return mv;
	}
	


	private static char Lire() {
		char C = 'A';
		boolean OK;
		do {
			OK = true;
			try {
				C = (char) System.in.read();
			}catch (java.io.IOException e) {

				OK = false;
			}
		} while (!OK);
		return C;
	}

	private static void ViderBuffer() {
		try {
			while (System.in.read() != '\n')
				;
		} catch (java.io.IOException e) {
		}
	}
}
