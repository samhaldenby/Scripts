#ifndef MOVECOMP_H_INCLUDED
#define MOVECOMP_H_INCLUDED

#include "Components.h"
#include "Vector2d.h"
#include "TypeDefs.h"

class MoveComp : public Component
{
    public:
        MoveComp(ObjectId id);
        void setMove(Vector2d v);
        Vector2d getMove();
    private:
        Vector2d move_;
};


#endif // MOVECOMP_H_INCLUDED
