package uqac.aop.chess.agent;

import java.util.Random;

import uqac.aop.chess.Board;

public class AiPlayer extends Player {
	// dies roooooll
	private Random Dies = new Random(0);

	public AiPlayer(int arg, Board board) {
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
		int iniX = -1, iniY = -1, finX = -1, finY = -1;

		do {
			iniX = Dies.nextInt(8);
			iniY = Dies.nextInt(8);
			finX = Dies.nextInt(8);
			finY = Dies.nextInt(8);
			mv = new Move(iniX, iniY, finX, finY);
		} while(!makeMove(mv, this.playGround));

		System.out.println("Votre coup? <" + mv.toString()+ ">");
		return mv;
	}
}
