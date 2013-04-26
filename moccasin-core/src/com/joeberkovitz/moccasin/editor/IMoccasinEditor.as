package com.joeberkovitz.moccasin.editor
{
	import com.joeberkovitz.moccasin.controller.IMoccasinController;

	import flash.events.IEventDispatcher;

	import mx.core.UIComponent;
	import mx.managers.IFocusManagerComponent;

	[Event(type="com.joeberkovitz.moccasin.event.EditorEvent", name="documentChanged")]
	[Event(type="com.joeberkovitz.moccasin.event.EditorEvent", name="documentLayoutChange")]
	[Event(type="com.joeberkovitz.moccasin.event.EditorEvent", name="displayScaleChange")]

	public interface IMoccasinEditor extends IFocusManagerComponent, IEventDispatcher
	{
		function get controller():IMoccasinController;

		function get feedbackLayer():UIComponent;

		function loadDocument(documentId:String):void;

		function saveDocument():void;

		function printDocument():void;

		///////////////////////////// not obligatory
//
//		function createController():IMoccasinController
//
//		function createDocumentLayer():UIComponent
//
//		function createDocumentView(context:ViewContext):IMoccasinView
//
//		function createDocumentService():IMoccasinDocumentService
//
//		function createKeyMediator(controller:IMoccasinController):EditorKeyMediator
//
//		function createViewContext(info:ViewInfo, controller:IMoccasinController, editor:IMoccasinEditor,
//		                           stage:Stage):ViewContext
	}
}
