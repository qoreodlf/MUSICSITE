package test;

public class tetst {
	public static void main(String[] args) {
		String url = "https://www.youtube.com/watch?v=oDnTaVFQGN4";
		String minuspart = "https://www.youtube.com/watch?v=";
		String id = url.substring(31);
		System.out.println(id);
	}
}
