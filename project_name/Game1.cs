using System;
using Microsoft.Xna.Framework;

namespace project_name
{
    class Game1 : Game
    {
        GraphicsDeviceManager graphics;
        
        public Game1()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
        }

        override protected void Initialize()
        {
            base.Initialize();
        }

        override protected void LoadContent()
        {
            base.LoadContent();
        }

        override protected void Update(GameTime gameTime)
        {
            base.Update(gameTime);
        }

        override protected void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            base.Draw(gameTime);
        }
    }
}