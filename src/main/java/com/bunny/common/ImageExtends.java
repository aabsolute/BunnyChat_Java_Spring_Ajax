package com.bunny.common;

public enum ImageExtends {
	JPG, PNG, GIF;
	
	public boolean word(String word) {
		
		for(ImageExtends str : ImageExtends.values())
		{
			if(word.equals(str.toString()))
				return true;
		}
		return false;
	}

	
}
