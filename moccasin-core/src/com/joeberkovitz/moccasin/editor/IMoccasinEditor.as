package com.joeberkovitz.moccasin.editor
{
	import com.joeberkovitz.moccasin.controller.IMoccasinController;

	import flash.events.IEventDispatcher;

	import mx.core.UIComponent;

	public interface IMoccasinEditor extends IEventDispatcher
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
