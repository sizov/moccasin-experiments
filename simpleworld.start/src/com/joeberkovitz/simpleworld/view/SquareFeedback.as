package com.joeberkovitz.simpleworld.view
{
    import com.joeberkovitz.moccasin.model.MoccasinModel;
    import com.joeberkovitz.moccasin.view.SelectionHandle;
    import com.joeberkovitz.moccasin.view.ViewContext;
    import com.joeberkovitz.simpleworld.controller.SizeDragMediator;
    import com.joeberkovitz.simpleworld.model.Square;

    /**
     * Feedback variation of a SquareView that displays associated resizing handle in the editor's
     * feedbackLayer UIComponent. Note that this extends ShapeView and thus inherits its position-tracking behavior.
     */
    public class SquareFeedback extends ShapeView
    {
        private var _sizeHandle:SelectionHandle;
        
        public function SquareFeedback(context:ViewContext, model:MoccasinModel=null)
        {
            super(context, model, false);
            initialize();
            
            new SizeDragMediator(context).handleViewEvents(this, _sizeHandle);
        }
        
        public function get square():Square
        {
            return model.value as Square;
        }
        
        override protected function createChildren():void
        {
            super.createChildren();

            // create the resize handle
            _sizeHandle = new SelectionHandle(context);
            addChild(_sizeHandle);
        }

        override protected function updateView():void
        {
            super.updateView();
            
            // Draw a gray selection border around the square
            graphics.lineStyle(1, 0x999999);
            graphics.drawRect(0, 0, square.size, square.size);

            // reposition the resizing handle
            _sizeHandle.x = _sizeHandle.y = square.size;
        }
    }
}