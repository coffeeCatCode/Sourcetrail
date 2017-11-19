#ifndef STORAGE_OCCURRENCE_H
#define STORAGE_OCCURRENCE_H

#include "utility/types.h"

struct StorageOccurrence
{
	StorageOccurrence()
		: elementId(0)
		, sourceLocationId(0)
	{}

	StorageOccurrence(Id elementId, Id sourceLocationId)
		: elementId(elementId)
		, sourceLocationId(sourceLocationId)
	{}

	Id elementId;
	Id sourceLocationId;
};

#endif // STORAGE_OCCURRENCE_H
