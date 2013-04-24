package com.joeberkovitz.simpleworld.model
{
	/**
	 * Value object representing a Square in the world.
	 */
	[RemoteClass]
	public class SquareImage extends Square
	{
		[Bindable]
		public var imageURL:String;
	}
}
