package com.joeberkovitz.simpleworld.view
{
	import com.joeberkovitz.moccasin.model.MoccasinModel;
	import com.joeberkovitz.moccasin.view.ViewContext;
	import com.joeberkovitz.simpleworld.model.SquareImage;

	import flash.display.Bitmap;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * View of a Square value object in the world.
	 */
	public class SquareImageView extends ShapeView
	{
		private var imageUrl:String;
		private var imageLoader:Loader;
		private var imageLoaderRequest:URLRequest;
		private var imageBitmap:Bitmap;

		public function SquareImageView(context:ViewContext, model:MoccasinModel = null)
		{
			super(context, model);
			initialize();
		}

		override protected function createChildren():void
		{
			super.createChildren();

			createImageLoader();
		}

		private function createImageLoader():void
		{
			imageLoader = new Loader();

			imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);

			imageLoaderRequest = new URLRequest();
		}

		override protected function updateModelProperty(property:Object, oldValue:Object, newValue:Object):Boolean
		{
			switch (String(property)) {
				case "imageUrl":
					updateImage();
					break;
				case "angle":
					updateRotation();
					break;
				case "x":
				case "y":
					updateOwnPosition();
					break;
				case "size":
					updateBackground();
					updateImageSize();
					break;
			}

			//always use update by properties, don't fallback to update all view
			return true;
		}

		//for image will be launched only during initialization
		override protected function updateView():void
		{
			//TODO: use UIComponent deferred validation
			updateOwnPosition();
			updateBackground();
			updateRotation();
			updateImageSize();
			updateImage();
		}

		private function updateImage():void
		{
			if (imageUrl != squareImage.imageURL) {
				imageUrl = squareImage.imageURL;
				loadImage();
			}
		}

		private function updateOwnPosition():void
		{
			x = shape.x;
			y = shape.y;
		}

		private function updateRotation():void
		{
			rotation = squareImage.angle * 180 / Math.PI;
		}

		private function updateBackground():void
		{
			graphics.clear();
			graphics.beginFill(squareImage.color);
			graphics.drawRect(-squareImage.size / 2, -squareImage.size / 2, squareImage.size, squareImage.size);
			graphics.endFill();
		}

		private function updateImageSize():void
		{
			if (!imageBitmap)return;

			//using letterbox for now
			var aspectRatio:Number = imageBitmap.width / imageBitmap.height;

			if (aspectRatio > 1) {
				imageBitmap.width = squareImage.size;
				imageBitmap.height = squareImage.size / aspectRatio;
			}
			else {
				imageBitmap.width = squareImage.size / aspectRatio;
				imageBitmap.height = squareImage.size;
			}

			//after size update, we need to tweek position
			imageBitmap.x = -imageBitmap.width / 2;
			imageBitmap.y = -imageBitmap.height / 2;
		}

		private function get squareImage():SquareImage
		{
			return SquareImage(model.value);
		}

		private function loadImage():void
		{
			//workaround for bug with invisible loader
			if (imageBitmap && contains(imageBitmap)) {
				removeChild(imageBitmap);
			}
			imageBitmap = null;

			imageLoaderRequest.url = imageUrl;
			imageLoader.load(imageLoaderRequest);
		}

		public function onProgressStatus(e:ProgressEvent):void
		{
			// this is where progress will be monitored
		}

		public function onLoaderReady(e:Event):void
		{
			imageBitmap = Bitmap(imageLoader.content);

			updateImageSize();

			addChild(imageBitmap);
		}

		//TODO: add hooks for removal of shape from scene => remove listener, unload loader

		/**
		 * Create a feedback view that will be superimposed on this view in a transparent layer.
		 */
		override protected function createFeedbackView():DisplayObject
		{
			return new SquareFeedback(context, model);
		}
	}
}
